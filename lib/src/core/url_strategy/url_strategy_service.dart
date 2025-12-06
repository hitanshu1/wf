import 'dart:async';
import 'dart:ui' as ui_web;
import 'dart:ui_web' as ui_web;

class UrlStrategyService {
  void init() {
    ui_web.urlStrategy = PathUrlStrategy();
  }
}

/// A clean URL strategy (no '#' in path).
/// Uses browser pathname directly for Flutter route syncing.
class PathUrlStrategy implements ui_web.UrlStrategy {
  PathUrlStrategy([
    this._platformLocation = const ui_web.BrowserPlatformLocation(),
    this.includeHash = false,
  ]) : _basePath = _extractBasePath(_platformLocation);

  final ui_web.PlatformLocation _platformLocation;
  final String _basePath;
  final bool includeHash;

  // ------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------
  static String _extractBasePath(ui_web.PlatformLocation platformLocation) {
    final href = platformLocation.getBaseHref();
    final uri = Uri.tryParse(href!);
    final path = uri?.path ?? '';
    return path.endsWith('/') ? path.substring(0, path.length - 1) : path;
  }

  // ------------------------------------------------------------
  // UrlStrategy overrides
  // ------------------------------------------------------------
  @override
  ui_web.VoidCallback addPopStateListener(ui_web.PopStateListener fn) {
    void wrappedFn(Object event) => fn(_platformLocation.state);
    _platformLocation.addPopStateListener(wrappedFn);
    return () => _platformLocation.removePopStateListener(wrappedFn);
  }

  @override
  String getPath() {
    final hash = includeHash ? (_platformLocation.hash ?? '') : '';
    final path = _platformLocation.pathname + _platformLocation.search + hash;
    if (_basePath.isNotEmpty && path.startsWith(_basePath)) {
      return path.substring(_basePath.length);
    }
    return path.isEmpty ? '/' : path;
  }

  @override
  Object? getState() => _platformLocation.state;

  @override
  String prepareExternalUrl(String internalUrl) {
    if (internalUrl.isEmpty) internalUrl = '/';
    assert(
      internalUrl.startsWith('/'),
      "PathUrlStrategy requires route names to start with '/'. "
      "Found: '$internalUrl'",
    );
    return '$_basePath$internalUrl';
  }

  @override
  void pushState(Object? state, String title, String url) {
    _platformLocation.pushState(state, title, prepareExternalUrl(url));
  }

  @override
  void replaceState(Object? state, String title, String url) {
    _platformLocation.replaceState(state, title, prepareExternalUrl(url));
  }

  @override
  Future<void> go(int count) {
    _platformLocation.go(count);
    return _waitForPopState();
  }

  Future<void> _waitForPopState() {
    final completer = Completer<void>();
    late ui_web.VoidCallback unsubscribe;
    unsubscribe = addPopStateListener((_) {
      unsubscribe();
      completer.complete();
    });
    return completer.future;
  }
}

import 'package:go_router/go_router.dart';


import '../../config/router/routes.dart';
import '../../config/router/routes_config.dart';
import '../di/service_locator.dart';

/// Centralized navigation helper for Kuick apps.
/// Static-style API using GetIt-injected GoRouter instance.
///
/// Example usage:
/// ```dart
/// KuickNavigation.to(Routes.dashboard);
/// KuickNavigation.to(Routes.project, params: {'id': '123'});
/// KuickNavigation.goNamed(Routes.login);
/// KuickNavigation.back();
/// ```

class KuickNavigation {
  /// Internal helper to get the GoRouter instance via GetIt
  static GoRouter get _router => sl<AppRouter>().router;

  // --------------------------------------------------------------------------
  // PUSH — Navigate to a route (keeps current in stack)
  // --------------------------------------------------------------------------
  static void to(
    KuickPath route, {
    Object? extra,
    Map<String, String>? params,
  }) {
    final uri = Uri(path: route.path, queryParameters: params);
    _router.push(uri.toString(), extra: extra);
  }

  /// Push using a raw path (useful for routes coming from shared packages).
  static void toPath(
    String path, {
    Object? extra,
  }) {
    _router.push(path, extra: extra);
  }

  // --------------------------------------------------------------------------
  // GO — Replace current route (no back stack)
  // --------------------------------------------------------------------------
  static void go(
    KuickPath route, {
    Object? extra,
    Map<String, String>? params,
  }) {
    final uri = Uri(path: route.path, queryParameters: params);
    _router.go(uri.toString(), extra: extra);
  }

  /// Replace current route using a raw path.
  static void goPath(
    String path, {
    Object? extra,
  }) {
    _router.go(path, extra: extra);
  }

  // --------------------------------------------------------------------------
  // POP — Go back
  // --------------------------------------------------------------------------
  static void back<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop(result);
    }
  }

  // --------------------------------------------------------------------------
  // PUSH NAMED — Using route name
  // --------------------------------------------------------------------------
  static void toNamed(
    KuickPath route, {
    Object? extra,
    Map<String, String>? params,
  }) {
    _router.pushNamed(route.name, queryParameters: params ?? {}, extra: extra);
  }

  // --------------------------------------------------------------------------
  // GO NAMED — Replace current route by name
  // --------------------------------------------------------------------------
  static void goNamed(
    KuickPath route, {
    Object? extra,
    Map<String, String>? params,
    Map<String, String>? pathParameters,
  }) {
    _router.goNamed(route.name, queryParameters: params ?? {}, extra: extra,pathParameters: pathParameters ?? {});
  }

  // --------------------------------------------------------------------------
  // REPLACE ALL — Clear stack and go to new route
  // --------------------------------------------------------------------------
  static void replaceAll(
    KuickPath route, {
    Object? extra,
    Map<String, String>? params,
  }) {
    while (_router.canPop()) {
      _router.pop();
    }
    final uri = Uri(path: route.path, queryParameters: params);
    _router.go(uri.toString(), extra: extra);
  }

  /// Clear stack and navigate using a raw path.
  static void replaceAllPath(
    String path, {
    Object? extra,
  }) {
    while (_router.canPop()) {
      _router.pop();
    }
    _router.go(path, extra: extra);
  }
}

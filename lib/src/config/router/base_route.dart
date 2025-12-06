import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/unknown_view.dart';
import 'routes.dart';

class KuickBase {
  static final Map<String, bool> _requireAuthByName = {};
  static final Map<String, bool> _requireAuthByPath = {};

  final KuickPath route;
  final Widget? screen;
  final Widget Function(BuildContext, GoRouterState)? argumentBuilder;
  final List<KuickBase> childRoutes;
  final Widget Function(BuildContext, GoRouterState, Widget)? shellBuilder;
  final bool requireAuth;
  final bool isShell;

  const KuickBase(
      this.route, {
        this.screen,
        this.argumentBuilder,
        this.childRoutes = const [],
        this.shellBuilder,
        this.requireAuth = false,
        this.isShell = false,
      });

  static bool requiresAuth(GoRouterState state) {
    final name = state.name;
    if (name != null && _requireAuthByName.containsKey(name)) {
      return _requireAuthByName[name] ?? false;
    }

    final matchedLocation =
        (state.fullPath ?? state.matchedLocation).split('?').first;
    if (_requireAuthByPath.containsKey(matchedLocation)) {
      return _requireAuthByPath[matchedLocation] ?? false;
    }
    return false;
  }

  void _registerAuthRequirement() {
    _requireAuthByName[route.name] = requireAuth;
    _requireAuthByPath[route.path] = requireAuth;
  }

  RouteBase toRouteBase() {
    _registerAuthRequirement();

    if (isShell && shellBuilder != null) {
      return ShellRoute(
        builder: (context, state, child) {
          return shellBuilder!(context, state, child);
        },
        routes: childRoutes.map((r) => r.toRouteBase()).toList(),
      );
    }

    // Always NO TRANSITION for this route
    return GoRoute(
      name: route.name,
      path: route.path,
      pageBuilder: (context, state) {
        final child =
            argumentBuilder?.call(context, state) ??
                screen ??
                const UnknownView();

        return NoTransitionPage(child: child);
      },
      routes: childRoutes.map((r) => r.toRouteBase()).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kuick_workflow/src/core/stubs/kuick_authflow_stub.dart' as auth;

import 'package:kuick_workflow/src/features/dashboard/presentation/screens/workspace.dart';
import '../../config/router/base_route.dart';
import '../../core/widgets/unknown_view.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/dashboard/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/widgets/home_screen_widgets/home_left_action_panel.dart';
import '../../features/dashboard/presentation/widgets/home_screen_widgets/workflow_screen.dart';
import '../../features/dashboard/presentation/widgets/left_action/debug_demo_view.dart';
import '../../features/dashboard/presentation/widgets/left_action/device_demo_view.dart';
import '../../features/dashboard/presentation/widgets/left_action/project_demo_view.dart';
import '../../features/dashboard/presentation/widgets/left_action/search_demo_view.dart';
import 'auth_guard.dart' show authGuard;
import 'routes.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: KuickRoutes.workspace.path,
      redirect: authGuard,
      routes: _routes,
      errorPageBuilder: (context, state) => const MaterialPage(child: UnknownView()),
      debugLogDiagnostics: true,
    );
  }

  List<RouteBase> get _routes => [
    ...auth.AuthRouter.authRoutes,
    _workspaceRoute.toRouteBase(),
    _userRoute.toRouteBase(),
  ];

  KuickBase get _workspaceRoute => KuickBase(KuickRoutes.workspace, screen: const Workspace(), requireAuth: false);

  KuickBase get _dashboardShellRoute => KuickBase(
    KuickRoutes.dashboard,
    isShell: true,
    shellBuilder: (context, state, child) => DashboardView(child: child),
    childRoutes: [
      KuickBase(KuickRoutes.workflow, screen: const ProjectDemoView(), requireAuth: true),
      KuickBase(KuickRoutes.search, screen: const SearchDemoView(), requireAuth: true),
      KuickBase(KuickRoutes.debug, screen: const DebugDemoView(), requireAuth: true),
      KuickBase(KuickRoutes.device, screen: const DeviceDemoView(), requireAuth: true),
    ],
  );

  KuickBase get _groupShellRoute => KuickBase(
    KuickRoutes.group,
    isShell: true,
    shellBuilder: (context, state, child) => HomeLeftSidebar(child: child),
    childRoutes: [
      KuickBase(
        KuickRoutes.home,
        screen: Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))),
        requireAuth: true,
      ),

      KuickBase(
        KuickRoutes.builder,
        screen: const HomeScreen(),
        requireAuth: true,
        childRoutes: [
          KuickBase(
            KuickRoutes.group,
            argumentBuilder: (context, state) {
              var groupId = state.uri.queryParameters["groupId"] ?? "";
              return WorkflowScreen(groupId: groupId);
            },
            requireAuth: true,
          ),
        ]
      ),

      KuickBase(
        KuickRoutes.setting,
        screen: Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))),
        requireAuth: true,
      ),
      KuickBase(
        KuickRoutes.widget,
        screen: Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))),
        requireAuth: true,
      ), KuickBase(
        KuickRoutes.keyboard,
        screen: Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))),
        requireAuth: true,
      ),

      KuickBase(
        KuickRoutes.history,
        screen: Center(child: Text("Coming Soon", style: TextStyle(fontSize: 20))),
        requireAuth: true,
      ),
    ],
  );

  KuickBase get _userRoute => KuickBase(
    KuickRoutes.workspaceDetails,
    argumentBuilder: (context, state) {
      state.pathParameters['workspaceId']!;
      return Container();
    },
    requireAuth: true,
    childRoutes: [
      KuickBase(
        KuickRoutes.projectDetails,
        argumentBuilder: (context, state) {
          state.pathParameters['workspaceId']!;
          state.pathParameters['projectId']!;
          return Container(); // create this
        },
        requireAuth: true,
        childRoutes: [
          _groupShellRoute,
          _dashboardShellRoute,
        ]
      ),
    ],
  );
}

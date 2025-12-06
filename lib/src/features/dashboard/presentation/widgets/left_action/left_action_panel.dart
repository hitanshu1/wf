import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kuick_workflow/src/core/utils/extensions/localization_extension.dart';
import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';

import '../../../../../config/router/routes.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/radius/radius.dart';
import '../../../../../config/theme/space/edge.dart';
import '../../../../../config/theme/space/gap.dart';
import '../../../../../core/navigation/kuick_navigation.dart';
import '../../../../../core/widgets/kuick_icon.dart';
import '../../../data/models/dashboard_model.dart';
import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_event.dart';
import '../../bloc/dashboard/dashboard_state.dart';

class LeftSidebar extends StatefulWidget {
  final Widget child;
  const LeftSidebar({super.key, required this.child});

  @override
  State<LeftSidebar> createState() => _LeftSidebarState();
}

class _LeftSidebarState extends State<LeftSidebar> {
  final ValueNotifier<double> sidebarWidth = ValueNotifier(260);

  @override
  Widget build(BuildContext context) {
    final routeList = <DashboardRouteItem>[
      DashboardRouteItem(
        route: KuickRoutes.workflow,
        label: context.l10n.project,
        icon: Icons.folder_open_outlined,
      ),
      DashboardRouteItem(
        route: KuickRoutes.search,
        label: context.l10n.search,
        icon: Icons.search_outlined,
      ),
      DashboardRouteItem(
        route: KuickRoutes.debug,
        label: context.l10n.debug,
        icon: Icons.bug_report_outlined,
      ),
      DashboardRouteItem(
        route: KuickRoutes.device,
        label: context.l10n.device,
        icon: Icons.devices_other_outlined,
      ),
    ];

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final bloc = context.read<DashboardBloc>();

        final currentLocation =
            GoRouterState.of(context).uri.toString().split('?').first;

        final selectedPath = state.selectedRoutePath ?? currentLocation;


        

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // -------------------------------
            // LEFT FIXED ICON SIDEBAR
            // -------------------------------
            Container(
              width: 80,
              color: Theme.of(context).colorScheme.surfaceContainerLowest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(routeList.length, (i) {
                    final item = routeList[i];
                    final isSelected = selectedPath == item.route.path;

                    return InkWell(
                      onTap: () {
                        bloc.add(SelectDashboardRoute(item.route.path));
                        KuickNavigation.goNamed(item.route);
                      },
                      borderRadius: radius.x8,
                      child: Padding(
                        padding: edge.v8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KuickIcon(
                              item.icon,
                              size: 22,
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            gap.h5,
                            item.label.asLabel(
                              context,
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // ----------------------------------
            // REALTIME RESIZABLE SIDEBAR (VALUE NOTIFIER)
            // ----------------------------------
            ValueListenableBuilder<double>(
              valueListenable: sidebarWidth,
              builder: (context, width, _) {
                return Container(
                  width: width,
                  color:
                  Theme.of(context).colorScheme.surfaceContainerLow,
                  child: widget.child,
                );
              },
            ),

            // ----------------------------------
            // DRAG HANDLE (ANDROID STUDIO STYLE)
            // ----------------------------------
            MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  final newWidth =
                  (sidebarWidth.value + details.delta.dx).clamp(
                    DashboardState.minSidebarWidth,
                    DashboardState.maxSidebarWidth,
                  );

                  // Real-time instant visual update
                  sidebarWidth.value = newWidth;

                  // Optional: keep Bloc synced without lag
                  bloc.add(UpdateSidebarWidth(newWidth));
                },
                child: Container(
                  width: 2,
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: 2,
                      color: AppColor.color1(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kuick_workflow/src/core/widgets/app_image.dart';

import '../../../../../config/router/routes.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/radius/radius.dart';
import '../../../../../config/theme/space/edge.dart';
import '../../../../../config/theme/space/gap.dart';
import '../../../../../core/navigation/kuick_navigation.dart';
import '../../../data/models/group_model.dart';
class HomeLeftSidebar extends StatefulWidget {
  final Widget child;

  const HomeLeftSidebar({super.key, required this.child});

  @override
  State<HomeLeftSidebar> createState() => _HomeLeftSidebarState();
}

class _HomeLeftSidebarState extends State<HomeLeftSidebar> {
  final ValueNotifier<double> sidebarWidth = ValueNotifier(260);
  late final List<HomeRouteItem> _routeList;
  late final List<HomeRouteItem> _bottomRouteList;
  String? _selectedRoutePath;

  @override
  void initState() {
    super.initState();
    _routeList = <HomeRouteItem>[
      HomeRouteItem(
        route: KuickRoutes.builder,
        icon: 'assets/svg/group.svg',
      ),
      HomeRouteItem(
        route: KuickRoutes.widget,
        icon: 'assets/svg/widget.svg',
      ),
    ];
    _bottomRouteList = <HomeRouteItem>[
      HomeRouteItem(
        route: KuickRoutes.keyboard,
        icon: 'assets/svg/keyboard.svg',
      ),
      HomeRouteItem(
        route: KuickRoutes.setting,
        icon: 'assets/svg/setting.svg',
      ),
      HomeRouteItem(
        route: KuickRoutes.history,
        icon: 'assets/svg/history.svg',
      ),
      HomeRouteItem(
        route: KuickRoutes.logout,
        icon: 'assets/svg/Logout.svg',
      ),
    ];
    _selectedRoutePath = _routeList.first.route.path;
  }

  void _handleRouteTap(HomeRouteItem item) {
    setState(() {
      _selectedRoutePath = item.route.path;
    });
    KuickNavigation.goNamed(item.route,pathParameters:  {
      'workspaceId': "123",
      'projectId': "456",
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation =
        GoRouterState.of(context).uri.toString().split('?').first;
    final selectedPath = _selectedRoutePath ?? currentLocation;

    return Column(
      children: [
        Container(
          height: 50,
          color: AppColor.color1(context),
          padding: edge.h16,
          width: double.infinity,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  KuickNavigation.goNamed(KuickRoutes.home,pathParameters:  {
                    'workspaceId': "123",
                    'projectId': "456",
                  });
                },
                child: AppImage('assets/svg/home.svg',
                    width: 25, color: AppColor.darkColor4),
              ),
              gap.w20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Test Project'), Text('Home')],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
          children: [
              Container(
                width: 51,
                color: AppColor.color1(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ..._routeList.map(
                      (item) => _SidebarIcon(
                        icon: item.icon,
                        isSelected: selectedPath == item.route.path,
                        onTap: () => _handleRouteTap(item),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: edge.h8,
                      child: const Divider(color: AppColor.darkColor4,),
                    ),
                    ..._bottomRouteList.map(
                      (item) => _SidebarIcon(
                        icon: item.icon,
                        isSelected: selectedPath == item.route.path,
                        onTap: () => _handleRouteTap(item),
                      ),
                    ),
                    const SizedBox(height: 74),
                  ],
                ),
              ),
              Expanded(
                child: widget.child,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarIcon extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarIcon({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final highlightColor =
        isSelected ? AppColor.darkColor4.withOpacity(0.15) : Colors.transparent;

    return InkWell(
      onTap: onTap,
      borderRadius: radius.x8,
      child: Padding(
        padding: edge.v8,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: edge.x8,
          decoration: BoxDecoration(
            color: highlightColor,
            borderRadius: radius.x8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,color: AppColor.darkColor4,

              ),
            ],
          ),
        ),
      ),
    );
  }
}

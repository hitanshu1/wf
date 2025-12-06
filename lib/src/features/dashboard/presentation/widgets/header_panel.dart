
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/radius/radius.dart';
import '../../../../config/theme/space/edge.dart';
import '../../../../config/theme/space/gap.dart';
import '../../../../core/storage/hive/hive_boxes.dart';
import '../../../../core/storage/storage_keys.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/bloc/theme_event.dart';
import '../../../../core/theme/bloc/theme_state.dart';
import '../../../../core/theme/theme_mode_enum.dart';
import '../../../../core/widgets/kuick_icon.dart';

class HeaderPanel extends StatefulWidget implements PreferredSizeWidget {
  final bool isLoaded;
  const HeaderPanel({super.key, this.isLoaded = false});

  @override
  State<HeaderPanel> createState() => _HeaderPanelState();

  @override
  Size get preferredSize => const Size.fromHeight(66);
}

class _HeaderPanelState extends State<HeaderPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.color1(context),
        border: Border(
          bottom: BorderSide(color: AppColor.color7(context), width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding:edge.l6.b8.t7,
                child: Theme.of(context).brightness == Brightness.dark
                    ? SvgPicture.asset('assets/svg/kuick_logo.svg')
                    : SvgPicture.asset('assets/svg/kuick_logo_light.svg'),
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChangeThemeButton(),
                    _notificationBtn(context),
                    _profileBatchBtn(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: InkWell(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 50,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: edge.x12,
                        decoration: BoxDecoration(
                          color: AppColor.color2(context),
                          borderRadius: radius.x5,
                        ),
                        child: Text(
                          'No new notifications',
                          
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          SvgPicture.asset(
            'assets/svg/notification.svg',
            color: Colors.grey.withValues(alpha: 0.5),
            height: 25,
            width: 25,
          ),
          Positioned(
            right: 0,
            top: -2,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.fixColor1,
              ),
              child: Center(
                child: Text(
                  '2',
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileBatchBtn(BuildContext parentContext) {
    return FutureBuilder<String>(
      future: getUserInitials(),
      builder: (context, snapshot) {
        String initials = snapshot.data ?? "?";
        return InkWell(
          onTap: () {},
          child: Container(
            height: 31,
            padding: edge.h12,
            decoration: BoxDecoration(
              borderRadius: radius.x5,
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.color5(context),
                  radius: 15,
                  child: Text(
                     initials,
                    // style: TextStyleTypography.typoNormalStyle12,
                    // color: AppColor.color9(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final currentMode = state.themeMode;

        // Determine if app is currently dark
        final isDark =
            currentMode == AppThemeMode.dark ||
            (currentMode == AppThemeMode.system &&
                theme.brightness == Brightness.dark);

        final icon = isDark ? Icons.dark_mode : Icons.light_mode;

        return IconButton(
          tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          icon: KuickIcon(icon),
          onPressed: () {
            final newMode = isDark ? AppThemeMode.light : AppThemeMode.dark;
            context.read<ThemeBloc>().add(ChangeTheme(newMode));
          },
        );
      },
    );
  }
}

Widget _menuItem({
  required String iconName,
  required String text,
  required BuildContext context,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        SvgPicture.asset(iconName),
        gap.h10,
        Text(
           text,
          
        ),
      ],
    ),
  );
}

Future<String> getUserInitials() async {
  try {
    final box = HiveBoxes.userBox;
    final user = box.get(StorageKeys.currentUser) ;

    String name = user?.data?.userDetails?.userName ?? "";
    String email = user?.data?.userDetails?.userEmail ?? "";
    if (name.trim().isNotEmpty) {
      final parts = name.trim().split(RegExp(r'\s+'));
      if (parts.length >= 2) {
        return (parts[0][0] + parts[1][0]).toUpperCase();
      }
      return parts[0][0].toUpperCase();
    } else if (email.contains('@')) {
      final prefix = email.split('@').first;
      return prefix.length >= 2
          ? prefix.substring(0, 2).toUpperCase()
          : prefix[0].toUpperCase();
    } else {
      return "";
    }
  } catch (e) {
    debugPrint("getUserInitials:: Error:: $e");
  }
  return "";
}

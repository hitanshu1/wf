import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../widgets/canvas_area_widgets/main_area_content.dart';
import '../widgets/header_panel.dart';
import '../widgets/footer_panel.dart';
import '../widgets/left_action/left_action_panel.dart';
import '../widgets/right_action_panel.dart';

class DashboardView extends StatelessWidget {
  final Widget child;
  const DashboardView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkColor6,
      appBar: const HeaderPanel(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              LeftSidebar(child: child),
              CanvasArea(),
              RightSidebar(),
            ],
          );
        },
      ),

      bottomNavigationBar: const FooterPanel(),
    );
  }
}


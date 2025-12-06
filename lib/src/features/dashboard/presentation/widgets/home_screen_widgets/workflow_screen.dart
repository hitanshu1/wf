import 'package:flutter/material.dart';

import '../../../../../config/router/routes.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/navigation/kuick_navigation.dart';
import '../../../data/models/local_models/group_model.dart';
import '../../screens/home_screen.dart';

class WorkflowScreen extends StatelessWidget {
  final String groupId;
  const WorkflowScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final workflows = [
      "My Workflow 6",
      "My Workflow 5",
      "My Workflow 4",
      "My Workflow 3",
      "My Workflow 2",
      "My Workflow",
    ];

    return Scaffold(
      backgroundColor: AppColor.color5(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: demoGroups.firstWhere((element) => element.id == groupId,orElse: () => demoGroups.first,).workFlowData.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _workflowTile(demoGroups.firstWhere((element) => element.id == groupId,orElse: () => demoGroups.first,).workFlowData[index],context);
          },
        ),
      ),
    );
  }

  Widget _workflowTile(WorkFlowModel data,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.color3(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.color6(context)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT SECTION (TITLE + SUBTITLE)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,

              ),
              const SizedBox(height: 6),
              const Text(
                "Last updated just now | Created 26 November",
              ),
            ],
          ),

          // RIGHT SECTION (BUTTON + MENU)
          Row(
            children: [
              // DESIGN BUTTON
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    KuickNavigation.goNamed(KuickRoutes.workflow,pathParameters: {
                      'workspaceId': "123",
                      'projectId': "456",
                    },params: {
                      "widgetId":data.widgetId,
                      "pageId" : data.pageId,
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColor.color2(context),
                      border: Border.all(color:  AppColor.color6(context)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.design_services, size: 16),
                        SizedBox(width: 6),
                        Text(
                          "Design",
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // 3 DOT MENU
              IconButton(
                icon: const Icon(Icons.more_vert, size: 20),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

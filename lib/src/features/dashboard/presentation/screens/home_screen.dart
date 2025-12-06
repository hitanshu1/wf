import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/router/routes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/space/gap.dart';
import '../../../../core/navigation/kuick_navigation.dart';
import '../../data/models/local_models/group_model.dart';
List<GroupModel> demoGroups = [
  GroupModel(
    icon: "assets/icons/group1.png",
    id: "1001",
    title: "Group 1",
    des: "Description for Group 1",
    workFlowData: [
      WorkFlowModel(id: "1101", title: "Workflow 11", des: "Workflow 1 description", pageId: "2101", widgetId: "3101"),
      WorkFlowModel(id: "1102", title: "Workflow 12", des: "Workflow 2 description", pageId: "2102", widgetId: "3102"),
      WorkFlowModel(id: "1103", title: "Workflow 13", des: "Workflow 3 description", pageId: "2103", widgetId: "3103"),
      WorkFlowModel(id: "1104", title: "Workflow 14", des: "Workflow 4 description", pageId: "2104", widgetId: "3104"),
      WorkFlowModel(id: "1105", title: "Workflow 15", des: "Workflow 5 description", pageId: "2105", widgetId: "3105"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group2.png",
    id: "1002",
    title: "Group 2",
    des: "Description for Group 2",
    workFlowData: [
      WorkFlowModel(id: "1201", title: "Workflow 21", des: "Workflow 1 description", pageId: "2201", widgetId: "3201"),
      WorkFlowModel(id: "1202", title: "Workflow 22", des: "Workflow 2 description", pageId: "2202", widgetId: "3202"),
      WorkFlowModel(id: "1203", title: "Workflow 23", des: "Workflow 3 description", pageId: "2203", widgetId: "3203"),
      WorkFlowModel(id: "1204", title: "Workflow 24", des: "Workflow 4 description", pageId: "2204", widgetId: "3204"),
      WorkFlowModel(id: "1205", title: "Workflow 25", des: "Workflow 5 description", pageId: "2205", widgetId: "3205"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group3.png",
    id: "1003",
    title: "Group 3",
    des: "Description for Group 3",
    workFlowData: [
      WorkFlowModel(id: "1301", title: "Workflow 31", des: "Workflow 1 description", pageId: "2301", widgetId: "3301"),
      WorkFlowModel(id: "1302", title: "Workflow 32", des: "Workflow 2 description", pageId: "2302", widgetId: "3302"),
      WorkFlowModel(id: "1303", title: "Workflow 33", des: "Workflow 3 description", pageId: "2303", widgetId: "3303"),
      WorkFlowModel(id: "1304", title: "Workflow 34", des: "Workflow 4 description", pageId: "2304", widgetId: "3304"),
      WorkFlowModel(id: "1305", title: "Workflow 35", des: "Workflow 5 description", pageId: "2305", widgetId: "3305"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group4.png",
    id: "1004",
    title: "Group 4",
    des: "Description for Group 4",
    workFlowData: [
      WorkFlowModel(id: "1401", title: "Workflow 41", des: "Workflow 1 description", pageId: "2401", widgetId: "3401"),
      WorkFlowModel(id: "1402", title: "Workflow 42", des: "Workflow 2 description", pageId: "2402", widgetId: "3402"),
      WorkFlowModel(id: "1403", title: "Workflow 43", des: "Workflow 3 description", pageId: "2403", widgetId: "3403"),
      WorkFlowModel(id: "1404", title: "Workflow 44", des: "Workflow 4 description", pageId: "2404", widgetId: "3404"),
      WorkFlowModel(id: "1405", title: "Workflow 45", des: "Workflow 5 description", pageId: "2405", widgetId: "3405"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group5.png",
    id: "1005",
    title: "Group 5",
    des: "Description for Group 5",
    workFlowData: [
      WorkFlowModel(id: "1501", title: "Workflow 51", des: "Workflow 1 description", pageId: "2501", widgetId: "3501"),
      WorkFlowModel(id: "1502", title: "Workflow 52", des: "Workflow 2 description", pageId: "2502", widgetId: "3502"),
      WorkFlowModel(id: "1503", title: "Workflow 53", des: "Workflow 3 description", pageId: "2503", widgetId: "3503"),
      WorkFlowModel(id: "1504", title: "Workflow 54", des: "Workflow 4 description", pageId: "2504", widgetId: "3504"),
      WorkFlowModel(id: "1505", title: "Workflow 55", des: "Workflow 5 description", pageId: "2505", widgetId: "3505"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group6.png",
    id: "1006",
    title: "Group 6",
    des: "Description for Group 6",
    workFlowData: [
      WorkFlowModel(id: "1601", title: "Workflow 61", des: "Workflow 1 description", pageId: "2601", widgetId: "3601"),
      WorkFlowModel(id: "1602", title: "Workflow 62", des: "Workflow 2 description", pageId: "2602", widgetId: "3602"),
      WorkFlowModel(id: "1603", title: "Workflow 63", des: "Workflow 3 description", pageId: "2603", widgetId: "3603"),
      WorkFlowModel(id: "1604", title: "Workflow 64", des: "Workflow 4 description", pageId: "2604", widgetId: "3604"),
      WorkFlowModel(id: "1605", title: "Workflow 65", des: "Workflow 5 description", pageId: "2605", widgetId: "3605"),
    ],
  ),

  GroupModel(
    icon: "assets/icons/group7.png",
    id: "1007",
    title: "Group 7",
    des: "Description for Group 7",
    workFlowData: [
      WorkFlowModel(id: "1701", title: "Workflow 71", des: "Workflow 1 description", pageId: "2701", widgetId: "3701"),
      WorkFlowModel(id: "1702", title: "Workflow 72", des: "Workflow 2 description", pageId: "2702", widgetId: "3702"),
      WorkFlowModel(id: "1703", title: "Workflow 73", des: "Workflow 3 description", pageId: "2703", widgetId: "3703"),
      WorkFlowModel(id: "1704", title: "Workflow 74", des: "Workflow 4 description", pageId: "2704", widgetId: "3704"),
      WorkFlowModel(id: "1705", title: "Workflow 75", des: "Workflow 5 description", pageId: "2705", widgetId: "3705"),
    ],
  ),
];
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 4; // Document icon is selected (5th item, 0-indexed)

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.color5(context),
      body: Column(
        children: [

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: demoGroups.length,
                    itemBuilder: (context, index) {
                      var data = demoGroups[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                           KuickNavigation.goNamed(KuickRoutes.group, params: {'groupId': data.id}, pathParameters: {
                            'workspaceId': "123",
                            'projectId': "456",
                          });
                          },
                          child: Container(
                            height: 88,
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.only(left: 12,top: 13,bottom: 15),
                            decoration: BoxDecoration(
                              color: AppColor.color3(context),
                              border: Border.all(color: AppColor.color6(context)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset('assets/svg/folderIcon.svg',color: AppColor.darkColor4,),
                                    gap.w10,
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data.title),
                                          Text(data.des),

                                        ]),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svg/workflow.svg'),
                                    gap.w10,
                                    Text('5 Workflow'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
          gap.h20,
        ],
      ),
    );
  }

  Widget _buildSidebarIcon(IconData icon, int index) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3A3A3A) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 24,
          color: isSelected ? Colors.white : Colors.grey[400], // Lighter grey for unselected
        ),
      ),
    );
  }
}

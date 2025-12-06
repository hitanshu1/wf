import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';
import '../../../../../config/constants/strings.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/radius/radius.dart';
import '../../../../../config/theme/space/edge.dart';
import '../../../../../config/theme/space/gap.dart';
import '../../../../../core/utils/color_converter.dart' show HexColor;
import '../../../data/models/workflow_model.dart';
import '../../bloc/dashboard/dashboard_bloc.dart';
import '../../bloc/dashboard/dashboard_state.dart';

class ProjectDemoView extends StatefulWidget {
  const ProjectDemoView({super.key});

  @override
  State<ProjectDemoView> createState() => _ProjectDemoViewState();
}

class _ProjectDemoViewState extends State<ProjectDemoView> {
  List<WorkflowMenu> workflowItems = [];

  @override
  void initState() {
    super.initState();
    loadWorkflowJson();
  }

  Future<void> loadWorkflowJson() async {
    final raw = await rootBundle.loadString(ExceptionPrefix.workflowJson);
    final decoded = jsonDecode(raw);

    workflowItems = (decoded["workflowMenu"] as List)
        .map((e) => WorkflowMenu.fromJson(e))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: workflowItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _buildSidebar(),
    );
  }

  /// ---------- COLLAPSIBLE SIDEBAR ----------
  Widget _buildSidebar() {
    return ListView(
      padding: edge.x12,
      children: workflowItems.map((menu) {
        return Container(
          margin: edge.b10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: radius.x12,
          ),
          child: ExpansionTile(
            backgroundColor: Colors.transparent,
            title: menu.parent.asH3(context),
            children: menu.children.map((child) {
              return _buildDraggableItem(child);
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  /// ---------- DRAGGABLE WRAPPER ----------
  Widget _buildDraggableItem(WorkflowChild child) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Draggable<WorkflowChild>(
          rootOverlay: true,
          data: child,
          maxSimultaneousDrags: context.read<DashboardBloc>().controller.nodes.isEmpty ? 1 : 0,
          dragAnchorStrategy: childDragAnchorStrategy,
          feedback: _buildDragPreview(child),
          childWhenDragging: Opacity(
            opacity: 0.4,
            child: _buildSidebarTile(child),
          ),
          child: _buildSidebarTile(child),
        );
      },
    );
  }

  /// ---------- SIDEBAR TILE UI ----------
  Widget _buildSidebarTile(WorkflowChild child) {
    return BlocBuilder<DashboardBloc, DashboardState>(
  builder: (context, state) {
    return Container(
      margin: edge.h12.v6,
      padding: edge.x12,
      decoration: BoxDecoration(
        color: AppColor.color5(context),
        borderRadius: radius.x10,
        border: Border.all(color: HexColor.fromHex(child.color)),
      ),

      child: Row(
        children: [
          SvgPicture.asset(child.icon, color: AppColor.color9(context)),
          gap.w10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child.title.asBody(context, size: 12),
                child.subtitle.asBody(context, size: 10),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }

  /// ---------- DRAG PREVIEW SHOWN ABOVE CANVAS ----------
  Widget _buildDragPreview(WorkflowChild child) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      elevation: 20,
      shadowColor: Colors.black54,
      child: IgnorePointer(
        child: Container(
          width: 240,
          padding: edge.x15,
          decoration: BoxDecoration(
            color: AppColor.color5(context),
            borderRadius: BorderRadius.circular(
              child.nodeUI.borderRadius.toDouble(),
            ),
            border: Border.all(color: HexColor.fromHex(child.color), width: 2),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(child.icon, color: AppColor.color9(context)),
                  gap.w10,
                  Expanded(child: child.title.asBody(context, size: 12)),
                ],
              ),
              gap.h5,
              child.subtitle.asBody(context, size: 10),
            ],
          ),
        ),
      ),
    );
  }
}

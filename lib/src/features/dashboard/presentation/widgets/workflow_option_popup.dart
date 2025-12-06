import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';
import '../../../../config/constants/strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/radius/radius.dart';
import '../../../../config/theme/space/edge.dart';
import '../../../../config/theme/space/gap.dart';
import '../../../../core/utils/color_converter.dart';
import '../../data/models/workflow_model.dart';

class WorkflowOptionPopup extends StatefulWidget {
  final Function(WorkflowChild?) onOptionSelected;

  const WorkflowOptionPopup({
    super.key,
    required this.onOptionSelected,
  });

  @override
  State<WorkflowOptionPopup> createState() => _WorkflowOptionPopupState();
}

class _WorkflowOptionPopupState extends State<WorkflowOptionPopup> {
  List<WorkflowChild> allOptions = [];

  @override
  void initState() {
    super.initState();
    loadOptions();
  }

  Future<void> loadOptions() async {
    final raw = await rootBundle.loadString(ExceptionPrefix.workflowJson);
    final decoded = jsonDecode(raw);

    final workflowMenus = (decoded["workflowMenu"] as List)
        .map((e) => WorkflowMenu.fromJson(e))
        .toList();

    allOptions = workflowMenus.expand((m) => m.children).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 360,
        constraints: const BoxConstraints(maxHeight: 460),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColor.color2(context),
          borderRadius: radius.x15,
        ),
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildList(context)),
          ],
        ),
      ),
    );
  }

  // HEADER -----------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: edge.h20.v16,
      decoration:  BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.color6(context), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "Choose Next step".asH3(context,size: 12),
          GestureDetector(
            onTap: () => widget.onOptionSelected(null),
            child: Icon(Icons.close, size: 20,color: AppColor.color9(context),),
          )
        ],
      ),
    );
  }

  // LIST -------------------------------------------------------
  Widget _buildList(BuildContext context) {
    if (allOptions.isEmpty) {
      return  Center(
        child: Padding(
          padding:edge.x20,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ListView.separated(
      padding: edge.x16,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: allOptions.length,
      itemBuilder: (context, i) => _buildItem(allOptions[i]),
    );
  }

  // ITEM -------------------------------------------------------
  Widget _buildItem(WorkflowChild item) {
    Color color = HexColor.fromHex(item.color);
    return InkWell(
      onTap: () => widget.onOptionSelected(item),
      borderRadius: radius.x12,
      child: Container(
        padding: edge.h16.v12,
        decoration: BoxDecoration(
          color: AppColor.color5(context),
          borderRadius: radius.x12,
          border: Border.all(color: AppColor.color6(context), width: 1),
        ),
        child: Row(
          children: [
            // Icon side
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: radius.x10,
              ),
              child: Icon(Icons.extension, size: 22, color: color),
            ),
            gap.w15,
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  item.title.asBody(context,size: 12,color: AppColor.color9(context)),
                  gap.h5,
                  item.subtitle.asBody(context,size: 10,color: AppColor.color8(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

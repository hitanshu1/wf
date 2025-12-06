import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/core/utils/extensions/string_extensions.dart';

import '../../../../../../config/theme/app_colors.dart';
import '../../../../../../config/theme/space/gap.dart';
import '../../../../../../core/utils/color_converter.dart';
import '../../../../../../core/widgets/app_image.dart';
import '../../../../data/models/local_models/node_config_model.dart';
import '../nodes_shape/chat_badge_shape.dart';
import '../nodes_shape/hexagon_shape.dart';

class NodeShapeWidget extends StatelessWidget {
  final Node<NodeConfigDataModel> item;
  final bool isSelected;
  final Color borderColor;
  final double borderWidth;
  final Color selectionColor;

  const NodeShapeWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.borderColor,
    required this.borderWidth,
    required this.selectionColor,
  });


  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget getContent(BuildContext context) {
    // Rectangle
    if (item.nodeShape == KuickNodeShape.rectangle) {
      return Container(
        width: item.size.value.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.color2(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: selectionColor.withValues(alpha: 0.25),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bolt,
                  color: HexColor.fromHex(item.data.color ?? ""),
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.data.title ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              item.data.subtitle ?? "",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      );
    }

    // Circle
    if (item.nodeShape == KuickNodeShape.circle) {
      return Container(
        width: item.size.value.width,
        height: item.size.value.height,
        decoration: BoxDecoration(
          color: AppColor.color2(context),
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Center(child: shapeChild(context)),
      );
    }

    // Chat Bubble
    if (item.nodeShape == KuickNodeShape.chatBubble) {
      return ChatBubble(
        width: item.size.value.width,
        height: item.size.value.height,
        color: HexColor.fromHex(item.data.color ?? ""),
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
          size: 48,
        ),
      );
    }

    // Diamond (Using Hexagon)
    if (item.nodeShape == KuickNodeShape.diamond) {
      return HexagonContainer(
        width: item.size.value.width,
        height: item.size.value.height,
        orientation: KuickNodeShape.hexagonVertical == item.nodeShape
            ? HexagonOrientation.vertical
            : HexagonOrientation.horizontal,
        sideRatio: 0.5,
        fillColor: AppColor.color2(context),
        strokeColor: borderColor,
        strokeWidth: 1,
        padding: const EdgeInsets.all(16),
        isSelected: isSelected,
        selectionColor: selectionColor,
        child: shapeChild(context),
      );
    }

    // Default Hexagon
    return HexagonContainer(
      width: item.size.value.width,
      height: item.size.value.height,
      orientation: KuickNodeShape.hexagonVertical == item.nodeShape
          ? HexagonOrientation.vertical
          : HexagonOrientation.horizontal,
      sideRatio: 0.2,
      fillColor: AppColor.color2(context),
      strokeColor: borderColor,
      strokeWidth: 1,
      padding: const EdgeInsets.all(16),
      isSelected: isSelected,
      selectionColor: selectionColor,
      child: shapeChild(context),
    );
  }

  Column shapeChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppImage(item.data.icon, height: 20),
        gap.h3,
        (item.data.title ?? "").asH3(context, size: 12),
        gap.h4,
        (item.data.subtitle ?? "").asBody(context, size: 10),
      ],
    );
  }

}

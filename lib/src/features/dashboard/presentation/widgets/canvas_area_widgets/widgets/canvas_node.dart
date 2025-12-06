import 'package:canvas_package/kuick_canvas.dart' hide Bottom;
import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/features/dashboard/presentation/widgets/workflow_option_popup.dart';
import '../../../../../../core/utils/color_converter.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../data/models/local_models/node_config_model.dart';
import '../../../../data/models/workflow_model.dart';
import 'node_shape_widget.dart';
import 'plus_button_widget.dart';



class CanvasNode extends StatefulWidget {
  final Node<NodeConfigDataModel> item;
  final Function(WorkflowChild workflowChild, PlusButtonPosition position, String parentNodeId, String direction, String buttonId)?
  onNextStepSelected;
  final bool isSelected;

  const CanvasNode({
    super.key,
    required this.item,
    this.onNextStepSelected,
    this.isSelected = false,
  });

  @override
  State<CanvasNode> createState() => _CanvasNodeState();
}

class _CanvasNodeState extends State<CanvasNode> {
  OverlayEntry? _popupEntry;

  void _closeOverlay() {
    _popupEntry?.remove();
    _popupEntry = null;
  }

  void _showOverlayPopup(BuildContext ctx, Offset pos, PlusButtonPosition position,String direction, String buttonId) {
    _closeOverlay();

    final overlay = Overlay.of(ctx);
    if (overlay == null) return;

    final screen = MediaQuery.of(ctx).size;

    const popupWidth = 400.0;
    const popupHeight = 500.0;

    double top = pos.dy - (popupHeight / 2);
    double left = pos.dx + 30;

    if (top < 10) top = 10;
    if (top + popupHeight > screen.height) {
      top = screen.height - popupHeight - 10;
    }

    if (left + popupWidth > screen.width) {
      left = pos.dx - popupWidth - 30;
    }

    if (left < 10) left = 10;

    _popupEntry = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeOverlay,
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              left: left,
              top: top,
              child: Material(
                color: Colors.transparent,
                child: WorkflowOptionPopup(
                  onOptionSelected: (child) {
                    _closeOverlay();
                    if (child != null) {
                      _disablePlusButtonPosition(position);
                      widget.onNextStepSelected?.call(child, position, widget.item.id,direction,buttonId);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_popupEntry!);
  }

  void _disablePlusButtonPosition(PlusButtonPosition position) {
    final plusPositions = widget.item.data.plusPositions;
    if (plusPositions == null || !mounted) return;

    bool updated = false;

    switch (position) {
      case PlusButtonPosition.top:
        if (plusPositions.top?.isNotEmpty ?? false) {
          plusPositions.top = [];
          updated = true;
        }
        break;
      case PlusButtonPosition.bottom:
        if (plusPositions.bottom?.isNotEmpty ?? false) {
          plusPositions.bottom = [];
          updated = true;
        }
        break;
      case PlusButtonPosition.left:
        if (plusPositions.left?.isNotEmpty ?? false) {
          plusPositions.left = [];
          updated = true;
        }
        break;
      case PlusButtonPosition.right:
        if (plusPositions.right?.isNotEmpty ?? false) {
          plusPositions.right = [];
          updated = true;
        }
        break;
    }

    if (updated) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final theme = Theme.of(context);
    final selectionColor = theme.colorScheme.primary;
    final defaultBorderColor = HexColor.fromHex(widget.item.data.color ?? "");
    final borderColor = widget.isSelected ? selectionColor : defaultBorderColor;
    final borderWidth = widget.isSelected ? 3.0 : 2.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        NodeShapeWidget(
          borderColor: borderColor,
          borderWidth: borderWidth,
          isSelected: widget.isSelected,
          selectionColor: selectionColor,
          item: item,
        ),

        if ((item.data.plusPositions?.top?.length ?? 0) > 0)
          Positioned(
            top: -14,
            left: item.size.value.width / 2 - 13,
            child: PlusButton(
              position: PlusButtonPosition.top,
              direction: "top",
              buttons: item.data.plusPositions?.top ?? [],
              onShowOverlay: (ctx, globalCenter, pos, dir, bottomId) {
                _showOverlayPopup(ctx, globalCenter, pos, dir, bottomId);
              },
            ),
          ),

        if ((item.data.plusPositions?.bottom?.length ?? 0) > 0)
          Positioned(
            bottom: -14,
            left: item.size.value.width / 2 - 13,
            child: PlusButton(
              position: PlusButtonPosition.bottom,
              direction: "bottom",
              buttons: item.data.plusPositions?.bottom ?? [],
              onShowOverlay: (ctx, globalCenter, pos, dir, bottomId) {
                _showOverlayPopup(ctx, globalCenter, pos, dir, bottomId);
              },
            ),
          ),

        if ((item.data.plusPositions?.left?.length ?? 0) > 0)
          Positioned(
            left: -14,
            top: item.size.value.height / 2 - 13,
            child: PlusButton(
              position: PlusButtonPosition.left,
              direction: "left",
              buttons: item.data.plusPositions?.left ?? [],
              onShowOverlay: (ctx, globalCenter, pos, dir, bottomId) {
                _showOverlayPopup(ctx, globalCenter, pos, dir, bottomId);
              },
            ),
          ),

        if ((item.data.plusPositions?.right?.length ?? 0) > 0)
          Positioned(
            right: -14,
            top: item.size.value.height / 2 - 13,
            child: PlusButton(
              position: PlusButtonPosition.right,
              direction: "right",
              buttons: item.data.plusPositions?.right ?? [],
              onShowOverlay: (ctx, globalCenter, pos, dir, bottomId) {
                _showOverlayPopup(ctx, globalCenter, pos, dir, bottomId);
              },
            ),
          ),
      ],
    );
  }
}

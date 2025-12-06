import 'package:flutter/material.dart';
import '../../../../../../config/theme/radius/radius.dart';
import '../../../../../../core/utils/defer_pointor/defer_pointer.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/kuick_icon.dart';
import '../../../../data/models/workflow_model.dart';

class PlusButton extends StatelessWidget {
  final PlusButtonPosition position;
  final String direction;
  final List<Bottom> buttons;

  /// Callback to show overlay (your existing `_showOverlayPopup`)
  final void Function(
      BuildContext context,
      Offset globalCenter,
      PlusButtonPosition position,
      String direction,
      String bottomId,
      ) onShowOverlay;

  /// Optional styling
  final double size;
  final Color color;
  final BorderRadiusGeometry? borderRadius;

  const PlusButton({
    super.key,
    required this.position,
    required this.direction,
    required this.buttons,
    required this.onShowOverlay,
    this.size = 26,
    this.color = Colors.orange,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return DeferPointer(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Builder(
          builder: (btnCtx) {
            return GestureDetector(
              onTap: () {
                final renderBox = btnCtx.findRenderObject() as RenderBox?;
                final globalCenter = renderBox != null
                    ? renderBox.localToGlobal(
                  renderBox.size.center(Offset.zero),
                )
                    : Offset.zero;

                final bottomId = buttons.isNotEmpty
                    ? (buttons.first.id ?? "01")
                    : "01";

                onShowOverlay(
                  btnCtx,
                  globalCenter,
                  position,
                  direction,
                  bottomId,
                );
              },
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: borderRadius ?? radius.x8, // your existing radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: KuickIcon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

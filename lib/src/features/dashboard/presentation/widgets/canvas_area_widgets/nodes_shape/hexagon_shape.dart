import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/material.dart';

class HexagonShape {
  HexagonShape({
    this.orientation = HexagonOrientation.horizontal,
    this.sideRatio = 0.2,
  }) : assert(
  sideRatio >= 0.0 && sideRatio <= 0.5,
  );

  final HexagonOrientation orientation;
  final double sideRatio;

  Path buildPath(Size size) {
    if (orientation == HexagonOrientation.horizontal) {
      return _buildHorizontalHexagon(size);
    } else {
      return _buildVerticalHexagon(size);
    }
  }

  Path _buildHorizontalHexagon(Size size) {
    final sideWidth = size.width * sideRatio;
    final centerY = size.height / 2;

    return Path()
      ..moveTo(sideWidth, 0) // Top left corner
      ..lineTo(size.width - sideWidth, 0) // Top right corner
      ..lineTo(size.width, centerY) // Right point
      ..lineTo(size.width - sideWidth, size.height) // Bottom right corner
      ..lineTo(sideWidth, size.height) // Bottom left corner
      ..lineTo(0, centerY) // Left point
      ..close();
  }

  Path _buildVerticalHexagon(Size size) {
    final sideHeight = size.height * sideRatio;
    final centerX = size.width / 2;

    return Path()
      ..moveTo(centerX, 0) // Top point
      ..lineTo(size.width, sideHeight) // Top right corner
      ..lineTo(size.width, size.height - sideHeight) // Bottom right corner
      ..lineTo(centerX, size.height) // Bottom point
      ..lineTo(0, size.height - sideHeight) // Bottom left corner
      ..lineTo(0, sideHeight) // Top left corner
      ..close();
  }
}

class HexagonClipper extends CustomClipper<Path> {
  final HexagonOrientation orientation;
  final double sideRatio;

  HexagonClipper({
    this.orientation = HexagonOrientation.horizontal,
    this.sideRatio = 0.2,
  });

  @override
  Path getClip(Size size) {
    final shape = HexagonShape(
      orientation: orientation,
      sideRatio: sideRatio,
    );
    return shape.buildPath(size);
  }

  @override
  bool shouldReclip(covariant HexagonClipper oldClipper) {
    return oldClipper.orientation != orientation ||
        oldClipper.sideRatio != sideRatio;
  }
}

class HexagonBorderPainter extends CustomPainter {
  final HexagonOrientation orientation;
  final double sideRatio;
  final Color strokeColor;
  final double strokeWidth;
  final Color? fillColor;

  HexagonBorderPainter({
    required this.orientation,
    required this.sideRatio,
    required this.strokeColor,
    required this.strokeWidth,
    this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shape = HexagonShape(
      orientation: orientation,
      sideRatio: sideRatio,
    );

    final path = shape.buildPath(size);

    if (fillColor != null) {
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = fillColor!;
      canvas.drawPath(path, fillPaint);
    }

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = strokeColor;

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant HexagonBorderPainter oldDelegate) {
    return oldDelegate.orientation != orientation ||
        oldDelegate.sideRatio != sideRatio ||
        oldDelegate.strokeColor != strokeColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.fillColor != fillColor;
  }
}

/// Reusable hexagon container with custom child
class HexagonContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final HexagonOrientation orientation;
  final double sideRatio;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final EdgeInsetsGeometry padding;
  final bool isSelected;
  final Color? selectionColor;

  const HexagonContainer({
    super.key,
    required this.child,
    this.width = 200,
    this.height = 120,
    this.orientation = HexagonOrientation.horizontal,
    this.sideRatio = 0.2,
    this.fillColor = Colors.white,
    this.strokeColor = Colors.black,
    this.strokeWidth =1,
    this.padding = const EdgeInsets.all(12),
    this.isSelected = false,
    this.selectionColor,
  });

  @override
  Widget build(BuildContext context) {
    final glowColor = selectionColor ?? strokeColor;
    return Container(
      width: width,
      height: height,

      child: CustomPaint(
        painter: HexagonBorderPainter(
          orientation: orientation,
          sideRatio: sideRatio,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
          fillColor: fillColor,
        ),
        child: ClipPath(
          clipper: HexagonClipper(
            orientation: orientation,
            sideRatio: sideRatio,
          ),
          child: Padding(
            padding: padding,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Extension methods for creating and modifying [TextStyle]s dynamically.
///
/// Use example:
/// ```dart
/// context.textTheme.bodyMedium!.size(16).bold.textColor(Colors.blue)
/// ```
extension TextStyleExtensions on TextStyle {
  // Font size
  TextStyle getSize(double v) => copyWith(fontSize: v);

  // Font weight
  TextStyle weight(FontWeight w) => copyWith(fontWeight: w);
  TextStyle get thin => weight(FontWeight.w100);
  TextStyle get light => weight(FontWeight.w300);
  TextStyle get regular => weight(FontWeight.w400);
  TextStyle get medium => weight(FontWeight.w500);
  TextStyle get semiBold => weight(FontWeight.w600);
  TextStyle get bold => weight(FontWeight.w700);
  TextStyle get black => weight(FontWeight.w900);

  // Colors
  TextStyle textColor(Color c) => copyWith(color: c);
  TextStyle opacity(double v) =>
      copyWith(color: color?.withValues(alpha: v.clamp(0.0, 1.0)));

  TextStyle invertColor() {
    if (color == null) return this;
    final inverted = Color.fromARGB(
      (color!.a * 255).round() & 0xFF,
      (255 - (color!.r * 255).round()) & 0xFF,
      (255 - (color!.g * 255).round()) & 0xFF,
      (255 - (color!.b * 255).round()) & 0xFF,
    );
    return copyWith(color: inverted);
  }

  // Spacing
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);
  TextStyle textHeight(double v) => copyWith(height: v);

  // Decorations
  TextStyle underline([Color? color, double? thickness]) => copyWith(
    decoration: TextDecoration.underline,
    decorationColor: color,
    decorationThickness: thickness,
  );
  TextStyle lineThrough([Color? color]) =>
      copyWith(decoration: TextDecoration.lineThrough, decorationColor: color);
  TextStyle removeDecoration() => copyWith(decoration: TextDecoration.none);

  // Style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get normal => copyWith(fontStyle: FontStyle.normal);

  // Shadows
  TextStyle shadow({
    required Color color,
    double blurRadius = 2.0,
    Offset offset = const Offset(1, 1),
  }) => copyWith(
    shadows: [Shadow(color: color, blurRadius: blurRadius, offset: offset)],
  );
}

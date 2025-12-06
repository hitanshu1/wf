import 'package:flutter/material.dart';
import '../../../config/theme/typography.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  // Typography helpers
  TextStyle get h1 => AppTypography.h1(this);
  TextStyle get h2 => AppTypography.h2(this);
  TextStyle get h3 => AppTypography.h3(this);
  TextStyle get body => AppTypography.body(this);
  TextStyle get caption => AppTypography.caption(this);
  TextStyle get label => AppTypography.label(this);

  // Colors
  Color get primary => colors.primary;
  Color get secondary => colors.secondary;
  Color get background => colors.surface;
  Color get onPrimary => colors.onPrimary;
}

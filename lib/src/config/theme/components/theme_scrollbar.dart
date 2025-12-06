import 'package:flutter/material.dart';
import '../app_colors.dart' show AppColor;

class AppScrollbarTheme {
  static final ScrollbarThemeData lightScrollbarTheme = ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(AppColor.lightColor8),
    trackColor: WidgetStateProperty.all(AppColor.lightColor8),
    thickness: WidgetStateProperty.all(6.0),
    radius: const Radius.circular(8),
    trackBorderColor: WidgetStateProperty.all(Colors.transparent),
  );

  static final ScrollbarThemeData darkScrollbarTheme = ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(AppColor.darkColor8),
    trackColor: WidgetStateProperty.all(AppColor.darkColor8),
    thickness: WidgetStateProperty.all(6.0),
    radius: const Radius.circular(8),
    trackBorderColor: WidgetStateProperty.all(Colors.transparent),
  );
}

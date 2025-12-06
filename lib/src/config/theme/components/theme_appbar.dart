import 'package:flutter/material.dart';
import '../app_colors.dart' show AppColor;

class AppAppBarTheme {
  static final AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColor.lightColor1,
    titleTextStyle: const TextStyle(
      color: AppColor.darkColor1,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  static const AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColor.darkColor1,
    titleTextStyle: TextStyle(
      color: AppColor.lightColor1,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

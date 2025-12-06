import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'components/theme_appbar.dart';
import 'components/theme_icon.dart';
import 'extensions/theme_extensions.dart';

/// AppThemes — contains ThemeData definitions and dynamic accessors.
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.lightColor9,
      secondary: AppColor.lightCanvasBg,
      surface: AppColor.lightColor2,
      onSurface: AppColor.lightColor9,
      onSecondary: AppColor.fixColor7,
      onPrimary: AppColor.fixColor3,
      error: AppColor.fixColor2,
      onError: AppColor.fixColor2,
      surfaceContainer: AppColor.lightColor3,
      primaryFixed: AppColor.fixColor3,
      primaryContainer: AppColor.lightCanvasBg,
      surfaceContainerLow: AppColor.lightColor1,
      onPrimaryFixed: AppColor.lightColor2,
      onPrimaryContainer: AppColor.lightColor3,
      onTertiaryContainer: AppColor.lightColor4,
      surfaceContainerLowest: AppColor.lightColor5,
      surfaceContainerHighest: AppColor.lightColor6,
      surfaceContainerHigh: AppColor.lightColor7,
      secondaryContainer: AppColor.lightColor8,
      tertiaryContainer: AppColor.lightColor9,
    ),
    scaffoldBackgroundColor: AppColor.lightCanvasBg,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    iconTheme: AppIconTheme.lightIconTheme,
    extensions: [AppThemeColors.light],
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.darkColor9,
      secondary: AppColor.darkCanvasBg,
      surface: AppColor.darkColor2,
      onSurface: AppColor.darkColor9,
      onSecondary: AppColor.fixColor7,
      onPrimary: AppColor.fixColor3,
      error: AppColor.fixColor2,
      onError: AppColor.fixColor2,
      surfaceContainer: AppColor.darkColor3,
      primaryFixed: AppColor.fixColor3,
      primaryContainer: AppColor.darkCanvasBg,
      surfaceContainerLow: AppColor.darkColor1,
      onPrimaryFixed: AppColor.darkColor2,
      onPrimaryContainer: AppColor.darkColor3,
      onTertiaryContainer: AppColor.darkColor4,
      surfaceContainerLowest: AppColor.darkColor5,
      surfaceContainerHighest: AppColor.darkColor6,
      surfaceContainerHigh: AppColor.darkColor7,
      secondaryContainer: AppColor.darkColor8,
      tertiaryContainer: AppColor.darkColor9,
    ),
    scaffoldBackgroundColor: AppColor.darkCanvasBg,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    iconTheme: AppIconTheme.darkIconTheme,
    appBarTheme: AppAppBarTheme.darkAppBarTheme,
    extensions: [AppThemeColors.dark],
  );
}

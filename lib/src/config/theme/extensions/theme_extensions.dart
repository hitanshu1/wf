// lib/src/config/theme/theme_extensions.dart
import 'package:flutter/material.dart';

import '../app_colors.dart';

/// A custom ThemeExtension for additional color properties not covered by Flutter's [ColorScheme].
/// This allows dynamic light/dark theming for your own brand tokens.
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color info;

  const AppThemeColors({required this.info});

  @override
  AppThemeColors copyWith({Color? info}) {
    return AppThemeColors(info: info ?? this.info);
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(info: Color.lerp(info, other.info, t)!);
  }

  static const light = AppThemeColors(info: AppColor.infoShade2);

  static const dark = AppThemeColors(info: AppColor.infoShade2);
}

/// Easy access to custom theme extensions.
extension AppThemeExtensionGetter on BuildContext {
  AppThemeColors get appColors => Theme.of(this).extension<AppThemeColors>()!;
}

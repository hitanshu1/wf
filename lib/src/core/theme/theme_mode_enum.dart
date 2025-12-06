enum AppThemeMode { system, light, dark }

extension AppThemeModeExtension on AppThemeMode {
  bool get isDark => this == AppThemeMode.dark;
  bool get isLight => this == AppThemeMode.light;
}

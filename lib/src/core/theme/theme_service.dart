import '../storage/hive/hive_boxes.dart';
import '../storage/storage_keys.dart';
import 'theme_mode_enum.dart';

class ThemeService {
  /// Get saved theme mode from Hive. Defaults to system.
  static Future<AppThemeMode> getThemeMode() async {
    final value =
        HiveBoxes.themeBox.get(
              StorageKeys.themeMode,
              defaultValue: AppThemeMode.system.index,
            )
            as int;
    return AppThemeMode.values[value];
  }

  /// Save theme mode to Hive
  static Future<void> saveThemeMode(AppThemeMode mode) async {
    await HiveBoxes.themeBox.put(StorageKeys.themeMode, mode.index);
  }
}

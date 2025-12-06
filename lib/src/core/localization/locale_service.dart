import '../storage/hive/hive_boxes.dart';
import '../storage/storage_keys.dart';

class LocaleService {
  /// Get saved locale code from Hive. Defaults to 'en'.
  static Future<String> getLocaleCode() async {
    final value = HiveBoxes.themeBox.get(
      StorageKeys.locale,
      defaultValue: 'en',
    );
    if (value is String && value.isNotEmpty) return value;
    return 'en';
  }

  /// Save locale code to Hive
  static Future<void> saveLocaleCode(String localeCode) async {
    await HiveBoxes.themeBox.put(StorageKeys.locale, localeCode);
  }
}


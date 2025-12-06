import 'package:hive/hive.dart';

import '../storage_keys.dart';

class HiveBoxes {
  static Box? _themeBox;
  static Box? _userBox;

  /// Opens all boxes required by the app.
  static Future<void> openAll() async {
    _themeBox = await Hive.openBox(StorageKeys.themeBox);
    _userBox = await Hive.openBox(StorageKeys.userBox);
  }

  /// Boxes getters for easy access
  static Box get themeBox => _themeBox!;
  static Box get userBox => _userBox!;

  /// Clear all boxes (useful for logout/reset)
  static Future<void> clearAll() async {
    await Future.wait([
      _themeBox?.clear() ?? Future.value(),
      _userBox?.clear() ?? Future.value(),
    ]);
  }
}

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'adepters/hive_adapters.dart';
import 'hive_boxes.dart';

class HiveManager {
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    // Initialize Hive for both mobile and web
    await Hive.initFlutter();

    // Register adapters
    HiveAdapters.registerAll();

    // Open boxes
    await HiveBoxes.openAll();

    _initialized = true;
  }

  Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}

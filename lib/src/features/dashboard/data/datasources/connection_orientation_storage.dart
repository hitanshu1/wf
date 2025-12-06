import 'dart:convert';

import '../../../../core/storage/hive/hive_boxes.dart';

class ConnectionOrientationStorage {
  static const _storageKey = 'connection_orientation_map';
  static Map<String, String>? _cache;

  static Map<String, String> _loadCache() {
    if (_cache != null) return _cache!;

    final stored = HiveBoxes.userBox.get(_storageKey);
    if (stored is String) {
      try {
        final decoded = jsonDecode(stored);
        if (decoded is Map<String, dynamic>) {
          _cache = decoded.map((key, value) => MapEntry(key, value.toString()));
        } else {
          _cache = {};
        }
      } catch (_) {
        _cache = {};
      }
    } else {
      _cache = {};
    }
    return _cache!;
  }

  static String _mapKey(String parentId, String childId) => '$parentId->$childId';

  static void save(String parentId, String childId, String direction) {
    final cache = _loadCache();
    cache[_mapKey(parentId, childId)] = direction;
    HiveBoxes.userBox.put(_storageKey, jsonEncode(cache));
  }

  static String? get(String parentId, String childId) {
    final cache = _loadCache();
    return cache[_mapKey(parentId, childId)];
  }
}


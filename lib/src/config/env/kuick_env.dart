// kuick_env.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

/// A small dotenv loader for Flutter.
///
/// Usage:
///   await dotenv.load();
///   final apiKey = dotenv.get('API_KEY', fallback: 'default');
///
/// Precedence when loading:
///   1. Values from fileName (base)
///   2. Values from overrideWithFiles (override values from base)
///   3. Values from mergeWith (highest priority)
KuickEnv kuickEnv = KuickEnv();

class KuickEnv {
  bool _isInitialized = false;
  final Map<String, String> _envMap = {};

  /// A copy of variables loaded at runtime.
  /// Throws [NotInitializedError] if load() / loadFromString() was not called.
  Map<String, String> get env {
    if (!_isInitialized) throw NotInitializedError();
    return Map.unmodifiable(_envMap);
  }

  bool get isInitialized => _isInitialized;

  /// Clears the currently loaded env map.
  void clean() {
    _envMap.clear();
    _isInitialized = false;
  }

  /// Returns the value for [name] or [fallback] if not present.
  /// Throws if missing and no fallback provided.
  String get(String name, {String? fallback}) {
    final value = maybeGet(name, fallback: fallback);
    if (value == null) {
      throw DotEnvError(
        'Environment variable "$name" not found. Provide a non-null fallback.',
      );
    }
    return value;
  }

  /// Returns value or null/fallback if missing without throwing.
  String? maybeGet(String name, {String? fallback}) {
    if (!_isInitialized) return fallback;
    return _envMap[name] ?? fallback;
  }

  /// Load env variable as int
  int getInt(String name, {int? fallback}) {
    final val = maybeGet(name);
    if (val == null) {
      if (fallback == null) {
        throw DotEnvError(
          'Missing integer env var "$name" and no fallback provided.',
        );
      }
      return fallback;
    }
    final parsed = int.tryParse(val);
    if (parsed == null) {
      throw FormatException(
        'Env var "$name" with value "$val" is not a valid int.',
      );
    }
    return parsed;
  }

  /// Load env variable as double
  double getDouble(String name, {double? fallback}) {
    final val = maybeGet(name);
    if (val == null) {
      if (fallback == null) {
        throw DotEnvError(
          'Missing double env var "$name" and no fallback provided.',
        );
      }
      return fallback;
    }
    final parsed = double.tryParse(val);
    if (parsed == null) {
      throw FormatException(
        'Env var "$name" with value "$val" is not a valid double.',
      );
    }
    return parsed;
  }

  /// Load env variable as bool
  /// Accepts (case-insensitive): true, false, 1, 0
  bool getBool(String name, {bool? fallback}) {
    final val = maybeGet(name);
    if (val == null) {
      if (fallback == null) {
        throw DotEnvError(
          'Missing boolean env var "$name" and no fallback provided.',
        );
      }
      return fallback;
    }
    final lower = val.toLowerCase();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
    throw FormatException(
      'Env var "$name" with value "$val" is not a valid boolean.',
    );
  }

  /// True if all supplied variables have non-empty values.
  /// Note: call load() / loadFromString() first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => (_envMap[k]?.isNotEmpty ?? false));

  /// Loads environment variables from the env file into a map.
  /// Precedence (lowest → highest): fileName, overrideWithFiles, mergeWith.
  Future<void> load({
    String fileName = '.env',
    List<String> overrideWithFiles = const [],
    Map<String, String> mergeWith = const {},
    bool isOptional = false,
    Parser parser = const Parser(),
  }) async {
    clean();
    List<String> linesFromFile = [];
    List<String> linesFromOverrides = [];

    try {
      linesFromFile = await _getEntriesFromFile(fileName);
      linesFromOverrides = await _getLinesFromOverride(overrideWithFiles);
    } on FileNotFoundError {
      if (!isOptional) rethrow;
      // else keep lists empty
    } on EmptyEnvFileError {
      if (!isOptional) rethrow;
    }

    final linesFromMergeWith = mergeWith.entries
        .map((e) => '${e.key}=${e.value}')
        .toList();

    // Base file, then overrides, then mergeWith (mergeWith has highest priority)
    final allLines = <String>[]
      ..addAll(linesFromFile)
      ..addAll(linesFromOverrides)
      ..addAll(linesFromMergeWith);

    final envEntries = parser.parse(allLines);
    _envMap.addAll(envEntries);
    _isInitialized = true;
  }

  /// Loads environment from a string (useful for tests)
  void loadFromString({
    required String envString,
    List<String> overrideWith = const [],
    Map<String, String> mergeWith = const {},
    bool isOptional = false,
    Parser parser = const Parser(),
  }) {
    clean();
    if (envString.isEmpty && !isOptional) {
      throw EmptyEnvFileError();
    }

    final linesFromFile = envString.isEmpty
        ? <String>[]
        : envString.split('\n');
    final linesFromOverrides = overrideWith
        .map((s) => s.split('\n'))
        .expand((x) => x)
        .toList();
    final linesFromMergeWith = mergeWith.entries
        .map((e) => '${e.key}=${e.value}')
        .toList();

    final allLines = <String>[]
      ..addAll(linesFromFile)
      ..addAll(linesFromOverrides)
      ..addAll(linesFromMergeWith);

    final envEntries = parser.parse(allLines);
    _envMap.addAll(envEntries);
    _isInitialized = true;
  }

  Future<List<String>> _getEntriesFromFile(String filename) async {
    try {
      // rootBundle.loadString requires the Flutter binding to be initialized
      // If called from a Flutter app lifecycle where it's already initialized, this is no-op.
      var envString = await rootBundle.loadString(filename);
      if (envString.isEmpty) {
        throw EmptyEnvFileError();
      }
      return envString.split('\n');
    } on FlutterError {
      throw FileNotFoundError();
    }
  }

  Future<List<String>> _getLinesFromOverride(List<String> overrideWith) async {
    final overrideLines = <String>[];
    for (final file in overrideWith) {
      final lines = await _getEntriesFromFile(file);
      overrideLines.addAll(lines);
    }
    return overrideLines;
  }
}

/// Base error for DotEnv library.
class DotEnvError extends Error {
  final String message;
  DotEnvError([this.message = 'DotEnv error occurred.']);

  @override
  String toString() => 'DotEnvError: $message';
}

class NotInitializedError extends Error {
  @override
  String toString() =>
      'DotEnv not initialized. Call load() or loadFromString() first.';
}

class FileNotFoundError extends Error {
  @override
  String toString() => 'Env file not found.';
}

class EmptyEnvFileError extends Error {
  @override
  String toString() => 'Env file is empty.';
}

/// Parser for simple .env like files.
class Parser {
  static const _singleQuote = "'";
  static final _leadingExport = RegExp(r'''^ *export ?''');
  static final _comment = RegExp(r'''#[^'"]*$''');
  static final _commentWithQuotes = RegExp(r'''#.*$''');
  static final _surroundQuotes = RegExp(r'''^(["'])(.*?[^\\])\1''');
  static final _bashVar = RegExp(r'''(\\)?(\$)(?:{)?([a-zA-Z_][\w]*)+(?:})?''');

  const Parser();

  /// Parses multiple lines into a map. Duplicate keys: first occurrence wins,
  /// but because we supply the list in load in order of lowest → highest precedence,
  /// later entries (higher precedence) will overwrite earlier ones by map.addAll().
  Map<String, String> parse(Iterable<String> lines) {
    final envMap = <String, String>{};
    for (final line in lines) {
      final kv = parseOne(line, envMap: envMap);
      if (kv.isEmpty) continue;
      // putIfAbsent preserves earlier value; callers typically call addAll on final map,
      // but here we want the first appearance to stick (caller controls order).
      envMap.putIfAbsent(kv.keys.single, () => kv.values.single);
    }
    return envMap;
  }

  /// Parse a single line into a map {key: value} or {} if invalid/blank/comment.
  Map<String, String> parseOne(
    String line, {
    Map<String, String> envMap = const {},
  }) {
    final trimmedWithoutComments = removeCommentsFromLine(line);
    if (!_isStringWithEqualsChar(trimmedWithoutComments)) return {};
    final indexOfEquals = trimmedWithoutComments.indexOf('=');
    final rawKey = trimmedWithoutComments.substring(0, indexOfEquals);
    final envKey = trimExportKeyword(rawKey).trim();
    if (envKey.isEmpty) return {};

    var envValue = trimmedWithoutComments.substring(indexOfEquals + 1).trim();
    final quoteChar = getSurroundingQuoteCharacter(envValue);
    var envValueWithoutQuotes = removeSurroundingQuotes(envValue);

    if (quoteChar == _singleQuote) {
      // In single-quoted values, do not interpolate variables; only unescape single quotes.
      envValueWithoutQuotes = envValueWithoutQuotes.replaceAll("\\'", "'");
      return {envKey: envValueWithoutQuotes};
    }

    if (quoteChar == '"') {
      envValueWithoutQuotes = envValueWithoutQuotes
          .replaceAll('\\"', '"')
          .replaceAll('\\n', '\n');
    }

    final interpolated = interpolate(
      envValueWithoutQuotes,
      envMap,
    ).replaceAll("\\\$", "\$");

    return {envKey: interpolated};
  }

  /// Interpolates $VARS from [env] into [val]. Unknown vars become empty string.
  String interpolate(String val, Map<String, String?> env) =>
      val.replaceAllMapped(_bashVar, (m) {
        // if escaped with backslash, return as-is
        if ((m.group(1) ?? '') == "\\") {
          return m.input.substring(m.start, m.end);
        } else {
          final k = m.group(3)!;
          if (!_has(env, k)) return '';
          return env[k]!;
        }
      });

  String getSurroundingQuoteCharacter(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val)!.group(1)!;
  }

  String removeSurroundingQuotes(String val) {
    if (!_surroundQuotes.hasMatch(val)) {
      return removeCommentsFromLine(val, includeQuotes: true).trim();
    }
    return _surroundQuotes.firstMatch(val)!.group(2)!;
  }

  String removeCommentsFromLine(String line, {bool includeQuotes = false}) =>
      line.replaceAll(includeQuotes ? _commentWithQuotes : _comment, '').trim();

  String trimExportKeyword(String line) =>
      line.replaceAll(_leadingExport, '').trim();

  bool _isStringWithEqualsChar(String s) => s.isNotEmpty && s.contains('=');

  bool _has(Map<String, String?> map, String key) =>
      map.containsKey(key) && map[key] != null;
}

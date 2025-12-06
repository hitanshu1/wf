import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Log {
  static const String _debug = "DEBUG";
  static const String _production = "PRODUCTION";
  static const String _info = "INFO";
  static const String _warning = "WARNING";
  static const String _error = "ERROR";
  static const String _success = "SUCCESS";

  /// ANSI color codes
  static const String _green = "\x1B[32m";
  static const String _yellow = "\x1B[33m";
  static const String _red = "\x1B[91m";
  static const String _blue = "\x1B[34m";
  static const String _white = "\x1B[37m";
  static const String _reset = "\x1B[0m";

  /// Helper method to format the log message with color
  static String _formatMessage(
    String level,
    String? label,
    String message,
    String color,
  ) {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final timestamp = formatter.format(now);
    final logLabel = label != null ? '[$label]' : '';
    return "$color[$timestamp][$level]$logLabel: $message$_reset";
  }

  /// Internal method to print log messages with color
  static void _appPrint(
    String type,
    String? label,
    dynamic message, {
    bool debugMode = true,
    String color = _white,
  }) {
    if (debugMode) {
      if (kDebugMode) {
        print(_formatMessage(type, label, message, color));
      }
    } else {
      print(_formatMessage(type, label, message, color));
    }
  }

  /// Public methods for different log levels
  static void d(dynamic message, {String? label}) {
    _appPrint(_debug, label, message.toString(), color: _blue);
  }

  static void p(dynamic message, {String? label}) {
    _appPrint(
      _production,
      label,
      message.toString(),
      debugMode: false,
      color: _blue,
    );
  }

  static void i(dynamic message, {String? label}) {
    _appPrint(_info, label, message.toString(), color: _blue);
  }

  static void w(dynamic message, {String? label}) {
    _appPrint(_warning, label, message.toString(), color: _yellow);
  }

  static void e(dynamic message, {String? label}) {
    _appPrint(_error, label, message.toString(), color: _red);
  }

  static void s(dynamic message, {String? label}) {
    _appPrint(_success, label, message.toString(), color: _green);
  }
}

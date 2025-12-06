import 'package:flutter/material.dart';
import '../radius/radius.dart';

class AppElevatedButtonTheme {
  static final ElevatedButtonThemeData lightButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: radius.x12,
          ),
        ),
      );

  static final ElevatedButtonThemeData darkButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: radius.x12,
          ),
        ),
      );
}

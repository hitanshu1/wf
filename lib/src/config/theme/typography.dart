import 'package:flutter/material.dart';

/// Define your app-wide text style system here.
/// These map to your ThemeData.textTheme but make it easier to reuse in extensions.
class AppTypography {
  static TextStyle h1(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge ??
      const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);

  static TextStyle h2(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium ??
      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  static TextStyle h3(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall ??
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static TextStyle body(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium ??
      const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall ??
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle label(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall ??
      const TextStyle(fontSize: 10, fontWeight: FontWeight.w300);
}

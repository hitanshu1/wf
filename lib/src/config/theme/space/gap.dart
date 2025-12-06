import 'package:flutter/material.dart';

/// Global spacing utility for consistent layout gaps.
///
/// Example usage:
/// ```dart
/// gap.h5, gap.w10, gap.h15
/// ```
final AppGap gap = const AppGap._();

/// Provides consistent spacing widgets for vertical and horizontal layout gaps.
/// Keeps internal SizedBox creation private for clean external usage.
class AppGap {
  const AppGap._();

  //------------------------------------------------------------------------------
  // Vertical Gaps (Height)
  //------------------------------------------------------------------------------

  SizedBox get h3 => _box(height: 3);
  SizedBox get h4 => _box(height: 4);
  SizedBox get h5 => _box(height: 5);
  SizedBox get h6 => _box(height: 6);
  SizedBox get h10 => _box(height: 10);
  SizedBox get h15 => _box(height: 15);
  SizedBox get h20 => _box(height: 20);
  SizedBox get h25 => _box(height: 25);
  SizedBox get h30 => _box(height: 30);
  SizedBox get h40 => _box(height: 40);
  SizedBox get h50 => _box(height: 50);

  //------------------------------------------------------------------------------
  // Horizontal Gaps (Width)
  //------------------------------------------------------------------------------

  SizedBox get w5 => _box(width: 5);
  SizedBox get w6 => _box(width: 6);
  SizedBox get w7 => _box(width: 7);
  SizedBox get w10 => _box(width: 10);
  SizedBox get w15 => _box(width: 15);
  SizedBox get w20 => _box(width: 20);
  SizedBox get w25 => _box(width: 25);
  SizedBox get w30 => _box(width: 30);
  SizedBox get w40 => _box(width: 40);
  SizedBox get w50 => _box(width: 50);

  //------------------------------------------------------------------------------
  // Common Utility
  //------------------------------------------------------------------------------

  SizedBox get none => const SizedBox.shrink();
  SizedBox get fullHeight => const SizedBox(height: double.infinity);
  SizedBox get fullWidth => const SizedBox(width: double.infinity);

  //------------------------------------------------------------------------------
  // Private SizedBox factory
  //------------------------------------------------------------------------------

  SizedBox _box({double? width, double? height}) {
    return SizedBox(width: width, height: height);
  }
}

import 'package:flutter/material.dart';

/// Global edge instance — simple shorthand usage
/// Example:
/// ```dart
/// padding: edge.x2,  // EdgeInsets.all(8)
/// margin: edge.h3,   // horizontal = 12
/// ```
final EdgeInsets edge = const EdgeInsets.all(0);

extension SuperEdgeInsets on EdgeInsets {
  // Base unit (you can tweak this for global spacing scale)
  static const double _x0 = 0;
  static const double _x3 = 3;
  static const double _x4 = 4;
  static const double _x6 = 6;
  static const double _x7 = 7;
  static const double _x8 = 8;
  static const double _x10 = 10;
  static const double _x12 = 12;
  static const double _x15 = 15;
  static const double _x16 = 16;
  static const double _x20 = 20;

  //------------------------------------------------------------------------------
  // All sides
  //------------------------------------------------------------------------------
  EdgeInsets _allF(double value) => EdgeInsets.all(value);
  EdgeInsets get x0  => _allF(_x0 );
  EdgeInsets get x4  => _allF(_x4 );
  EdgeInsets get x8  => _allF(_x8 );
  EdgeInsets get x12 => _allF(_x12);
  EdgeInsets get x15 => _allF(_x15);
  EdgeInsets get x16 => _allF(_x16);
  EdgeInsets get x20 => _allF(_x20);

  //------------------------------------------------------------------------------
  // Horizontal only
  //------------------------------------------------------------------------------
  EdgeInsets hF(double value) => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets get h4  => hF(_x4 );
  EdgeInsets get h6  => hF(_x6 );
  EdgeInsets get h8  => hF(_x8 );
  EdgeInsets get h12 => hF(_x12);
  EdgeInsets get h16 => hF(_x16);
  EdgeInsets get h20 => hF(_x20);

  //------------------------------------------------------------------------------
  // Vertical only
  //------------------------------------------------------------------------------
  EdgeInsets vF(double value) => EdgeInsets.symmetric(vertical: value);
  EdgeInsets get v3  => vF(_x3 );
  EdgeInsets get v4  => vF(_x4 );
  EdgeInsets get v6  => vF(_x6 );
  EdgeInsets get v8  => vF(_x8 );
  EdgeInsets get v12 => vF(_x12);
  EdgeInsets get v16 => vF(_x16);
  EdgeInsets get v20 => vF(_x20);

  //------------------------------------------------------------------------------
  // Top only
  //------------------------------------------------------------------------------
  EdgeInsets tF(double value) => EdgeInsets.only(top: value);
  EdgeInsets get t4  => tF(_x4 );
  EdgeInsets get t7  => tF(_x7 );
  EdgeInsets get t8  => tF(_x8 );
  EdgeInsets get t12 => tF(_x12);
  EdgeInsets get t16 => tF(_x16);
  EdgeInsets get t20 => tF(_x20);

  //------------------------------------------------------------------------------
  // Bottom only
  //------------------------------------------------------------------------------
  EdgeInsets bF(double value) => EdgeInsets.only(bottom: value);
  EdgeInsets get b4  => bF(_x4 );
  EdgeInsets get b6  => bF(_x6 );
  EdgeInsets get b8  => bF(_x8 );
  EdgeInsets get b10  => bF(_x10 );
  EdgeInsets get b12 => bF(_x12);
  EdgeInsets get b16 => bF(_x16);
  EdgeInsets get b20 => bF(_x20);

  //------------------------------------------------------------------------------
  // Left only
  //------------------------------------------------------------------------------
  EdgeInsets lF(double value) => EdgeInsets.only(left: value);
  EdgeInsets get l4  => lF(_x4 );
  EdgeInsets get l6  => lF(_x6 );
  EdgeInsets get l8  => lF(_x8 );
  EdgeInsets get l12 => lF(_x12);
  EdgeInsets get l16 => lF(_x16);
  EdgeInsets get l20 => lF(_x20);

  //------------------------------------------------------------------------------
  // Right only
  //------------------------------------------------------------------------------
  EdgeInsets rF(double value) => EdgeInsets.only(right: value);
  EdgeInsets get r4  => rF(_x4 );
  EdgeInsets get r8  => rF(_x8 );
  EdgeInsets get r10  => rF(_x10 );
  EdgeInsets get r12 => rF(_x12);
  EdgeInsets get r16 => rF(_x16);
  EdgeInsets get r20 => rF(_x20);
}

import 'package:flutter/material.dart';

/// Global base for quick radius usage
/// Example:
/// ```dart
/// borderRadius: radius.x10,   // All corners = 10
/// borderRadius: radius.t20,   // Top corners = 20
/// ```

final BorderRadius radius = BorderRadius.zero;

extension SuperRadius on BorderRadius {
  // Radius values
  static const double _r5 = 5;
  static const double _r8 = 8;
  static const double _r10 = 10;
  static const double _r12 = 12;
  static const double _r15 = 15;
  static const double _r20 = 20;
  static const double _r25 = 25;
  static const double _r = 500;

  //------------------------------------------------------------------------------
  // All corners
  //------------------------------------------------------------------------------
  BorderRadius allF(double value) => BorderRadius.circular(value);
  BorderRadius get x5 => allF(_r5);
  BorderRadius get x8 => allF(_r8);
  BorderRadius get x10 => allF(_r10);
  BorderRadius get x12 => allF(_r12);
  BorderRadius get x15 => allF(_r15);
  BorderRadius get x20 => allF(_r20);
  BorderRadius get x25 => allF(_r25);
  BorderRadius get x => allF(_r);

  //------------------------------------------------------------------------------
  // Left side (topLeft + bottomLeft)
  //------------------------------------------------------------------------------
  BorderRadius lF(double value) => BorderRadius.only(
    topLeft: Radius.circular(value),
    bottomLeft: Radius.circular(value),
  );
  BorderRadius get l5 => lF(_r5);
  BorderRadius get l10 => lF(_r10);
  BorderRadius get l15 => lF(_r15);
  BorderRadius get l20 => lF(_r20);
  BorderRadius get l25 => lF(_r25);

  //------------------------------------------------------------------------------
  // Right side (topRight + bottomRight)
  //------------------------------------------------------------------------------
  BorderRadius rF(double value) => BorderRadius.only(
    topRight: Radius.circular(value),
    bottomRight: Radius.circular(value),
  );
  BorderRadius get r5 => rF(_r5);
  BorderRadius get r10 => rF(_r10);
  BorderRadius get r15 => rF(_r15);
  BorderRadius get r20 => rF(_r20);
  BorderRadius get r25 => rF(_r25);

  //------------------------------------------------------------------------------
  // Top side (topLeft + topRight)
  //------------------------------------------------------------------------------
  BorderRadius tF(double value) => BorderRadius.only(
    topLeft: Radius.circular(value),
    topRight: Radius.circular(value),
  );
  BorderRadius get t5 => tF(_r5);
  BorderRadius get t10 => tF(_r10);
  BorderRadius get t15 => tF(_r15);
  BorderRadius get t20 => tF(_r20);
  BorderRadius get t25 => tF(_r25);

  //------------------------------------------------------------------------------
  // Bottom side (bottomLeft + bottomRight)
  //------------------------------------------------------------------------------
  BorderRadius bF(double value) => BorderRadius.only(
    bottomLeft: Radius.circular(value),
    bottomRight: Radius.circular(value),
  );
  BorderRadius get b5 => bF(_r5);
  BorderRadius get b10 => bF(_r10);
  BorderRadius get b15 => bF(_r15);
  BorderRadius get b20 => bF(_r20);
  BorderRadius get b25 => bF(_r25);

  //------------------------------------------------------------------------------
  // Individual corners
  //------------------------------------------------------------------------------
  BorderRadius tlF(double value) =>
      BorderRadius.only(topLeft: Radius.circular(value));
  BorderRadius get tl5 => tlF(_r5);
  BorderRadius get tl10 => tlF(_r10);
  BorderRadius get tl15 => tlF(_r15);
  BorderRadius get tl20 => tlF(_r20);
  BorderRadius get tl25 => tlF(_r25);
  BorderRadius get tl => tlF(_r);

  BorderRadius trF(double value) =>
      BorderRadius.only(topRight: Radius.circular(value));
  BorderRadius get tr5 => trF(_r5);
  BorderRadius get tr10 => trF(_r10);
  BorderRadius get tr15 => trF(_r15);
  BorderRadius get tr20 => trF(_r20);
  BorderRadius get tr25 => trF(_r25);
  BorderRadius get tr => trF(_r);

  BorderRadius blF(double value) =>
      BorderRadius.only(bottomLeft: Radius.circular(value));
  BorderRadius get bl5 => blF(_r5);
  BorderRadius get bl10 => blF(_r10);
  BorderRadius get bl15 => blF(_r15);
  BorderRadius get bl20 => blF(_r20);
  BorderRadius get bl25 => blF(_r25);
  BorderRadius get bl => blF(_r);

  BorderRadius brF(double value) =>
      BorderRadius.only(bottomRight: Radius.circular(value));
  BorderRadius get br5 => brF(_r5);
  BorderRadius get br10 => brF(_r10);
  BorderRadius get br15 => brF(_r15);
  BorderRadius get br20 => brF(_r20);
  BorderRadius get br25 => brF(_r25);
  BorderRadius get br => brF(_r);
}

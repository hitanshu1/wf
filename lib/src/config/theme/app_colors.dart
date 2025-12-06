import 'package:flutter/material.dart';

/// Contains all color constants used in the app.
/// No Theme/Bloc dependency — pure tokens.
class AppColor {
  // ---------------------- Dark Colors ----------------------
  static const Color darkCanvasBg = Color(0xFF696969);
  static const Color darkColor1 = Color(0xFF161616);
  static const Color darkColor2 = Color(0xFF202020);
  static const Color darkColor3 = Color(0xFF222222);
  static const Color darkColor4 = Color(0xFF494949);
  static const Color darkColor5 = Color(0xFF282828);
  static const Color darkColor6 = Color(0xFF494949);
  static const Color darkColor7 = Color(0xFF282828);
  static const Color darkColor8 = Color(0xFFA5A5A5);
  static const Color darkColor9 = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ---------------------- Light Colors ----------------------
  static const Color lightCanvasBg = Color(0xFFDADADA);
  static const Color lightColor1 = Color(0xffEBEBEB);
  static const Color lightColor2 = Color(0xFFF3F3F3);
  static const Color lightColor3 = Color(0xFFF0F0F0);
  static const Color lightColor4 = Color(0xFFD0D0D0);
  static const Color lightColor5 = Color(0xFFE6E6E6);
  static const Color lightColor6 = Color(0xFFD0D0D0);
  static const Color lightColor7 = Color(0xFFE1E1E1);
  static const Color lightColor8 = Color(0xFF616161);
  static const Color lightColor9 = Color(0xFF0E121B);

  // ---------------------- App & Status Colors ----------------------
  static const Color alertColor = Color(0xFFD3302F);
  static const Color lightBlueColor = Color(0xFF53B3DD);
  static const Color appBlueColor = Color(0xFF1874DA);
  static const Color lightGreenColor = Color(0xFF8FC147);
  static const Color infoShade2 = Color(0xFF66B8E3);

  // ---------------------- Hover Colors ----------------------
  static const Color blueHoverColor = Color(0xFF2F8AEE);
  static const Color redHoverColor = Color(0xFFE74140);

  // ---------------------- Fixed Palette ----------------------
  static const Color fixColor1 = Color(0xFFFFFFFF);
  static const Color fixColor2 = Color(0xFFD3302F);
  static const Color fixColor3 = Color(0xFF1874DA);
  static const Color fixColor4 = Color(0xFF000000);
  static const Color fixColor5 = Color(0xFFDFDFDF);
  static const Color fixSuccess = Color(0xFF59975A);
  static const Color fixColor6 = Color(0xFFE78F47);
  static const Color fixColor7 = Color(0xFF627884);
  static const Color fixColor8 = Color(0xFFEAE202);
  static const Color fixColor9 = Color(0xFFB661FB);
  static const Color fixColor10 = Color(0xFF08E6FF);
  static const Color fixColor11 = Color(0xFF32FF05);
  static const Color fixColor12 = Color(0xFF37D4FF);
  static const Color fixColor13 = Color(0xFF01BC5B);
  static const Color fixColor14 = Color(0xFFEA8202);
  static const Color fixColor15 = Color(0xFFD80404);

  // ------------------- THEME ACCESS HELPERS -------------------
  static Color canvasBg(BuildContext context) =>
      Theme.of(context).colorScheme.primaryContainer;


  static Color color1(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLow;

  static Color color2(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryFixed;

  static Color color3(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimaryContainer;

  static Color color4(BuildContext context) =>
      Theme.of(context).colorScheme.onTertiaryContainer;

  static Color color5(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerLowest;

  static Color color6(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHighest;

  static Color color7(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainerHigh;

  static Color color8(BuildContext context) =>
      Theme.of(context).colorScheme.secondaryContainer;

  static Color color9(BuildContext context) =>
      Theme.of(context).colorScheme.tertiaryContainer;

  static Color errorColor(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  static Color successColor(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  static Color appColor(BuildContext context) =>
      Theme.of(context).colorScheme.primaryFixed;
}

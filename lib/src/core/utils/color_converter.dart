import 'dart:ui';

class HexColor extends Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll("#", "");
    return Color(int.parse("FF$hex", radix: 16));
  }

  HexColor(super.value);
}
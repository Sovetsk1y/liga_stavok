import 'package:flutter/painting.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return int.parse("FF4A4A4A", radix: 16);
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

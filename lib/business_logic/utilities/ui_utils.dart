import 'package:flutter/material.dart';

Color hexToColor(String hexClr) {
  String hexColor = hexClr.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor += "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

Container devider(BuildContext context, double opacity) => Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.grey.withOpacity(opacity),
    );

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

import 'package:flutter/material.dart';

class Responsive {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
  }

  static double height(double percentage) {
    return screenHeight * percentage;
  }

  static double width(double percentage) {
    return screenWidth * percentage;
  }
}

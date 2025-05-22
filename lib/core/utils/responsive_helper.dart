import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
  }

  static double wPixel(double px) => (px / 375) * screenWidth;
  static double hPixel(double px) => (px / 812) * screenHeight;
}

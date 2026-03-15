import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Lato';

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  // Headline
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // Label
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
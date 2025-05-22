import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

abstract class AppTextStyles {
  static final TextStyle inputText = GoogleFonts.lato(
      color: AppColors.inputTextColor,
      fontSize: ResponsiveHelper.wPixel(16),
  );

  static final TextStyle textButtonDisabled = GoogleFonts.lato(
      color: AppColors.disabledTextColor,
      fontSize: ResponsiveHelper.wPixel(16),
  );

  static final TextStyle normal16 = GoogleFonts.lato(
      color: AppColors.whiteColor,
      fontSize: ResponsiveHelper.wPixel(16),
      height: ResponsiveHelper.hPixel(1.5),
  );

  static final TextStyle primaryTextColor = GoogleFonts.lato(
    color: AppColors.primaryColor,
    fontSize: ResponsiveHelper.wPixel(16),
    height: ResponsiveHelper.hPixel(1.5),
  );

  static final TextStyle bold32 = GoogleFonts.lato(
    color: AppColors.whiteColor,
    fontSize: ResponsiveHelper.wPixel(32),
    fontWeight: FontWeight.bold,
    // height: ResponsiveHelper.hPixel()
  );
  static final TextStyle bold20 = GoogleFonts.lato(
    color: AppColors.whiteColor,
    fontSize: ResponsiveHelper.wPixel(20),
    fontWeight: FontWeight.bold,
    // height: ResponsiveHelper.hPixel()
  );

  static final TextStyle normal20 = GoogleFonts.lato(
    color: AppColors.whiteColor,
    fontSize: ResponsiveHelper.wPixel(20),
    // height: ResponsiveHelper.hPixel()
  );

  static final TextStyle medium20 = GoogleFonts.lato(
    color: AppColors.whiteColor,
    fontSize: ResponsiveHelper.wPixel(20),
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body1 = GoogleFonts.lato(
    fontSize: 16,
    color: Colors.black,
  );

  static final TextStyle regularText2 = GoogleFonts.lato(
    fontSize: 12,
    color: AppColors.borderColor,
  );

  static final TextStyle normal12 = GoogleFonts.lato(
    fontSize: 12,
    color: AppColors.whiteColor,
  );

  static final TextStyle bold16 = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

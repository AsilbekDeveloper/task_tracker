import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class SocialButtonWidget extends StatelessWidget {
  final String logoPath;
  final String text;
  final VoidCallback onTap;

  const SocialButtonWidget({
    super.key,
    required this.logoPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: ResponsiveHelper.hPixel(48),
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: AppColors.primaryColor,
            width: ResponsiveHelper.wPixel(1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.hPixel(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logoPath, height: ResponsiveHelper.hPixel(24),),
              SizedBox(width: ResponsiveHelper.wPixel(10)),
              Text(text, style: AppTextStyles.normal16),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class SettingGroupWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  const SettingGroupWidget({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: AppColors.whiteColor),
          SizedBox(width: ResponsiveHelper.wPixel(10)),
          Text(
            text,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: ResponsiveHelper.wPixel(16),
              height: ResponsiveHelper.hPixel(1.5),
            ),
          ),
          Spacer(),
          Icon(IconsaxPlusLinear.arrow_right_3, color: AppColors.whiteColor),
        ],
      ),
    );
  }
}

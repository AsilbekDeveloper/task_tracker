import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';

class SettingGroupWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  const SettingGroupWidget({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface),
          SizedBox(width: 10.w),
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16.w,
              height: 1.5.h,
            ),
          ),
          Spacer(),
          Icon(IconsaxPlusLinear.arrow_right_3, color: AppColors.brandPrimary),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';

class PriorityNumber extends StatelessWidget {
  final int number;
  final bool isSelected;
  final VoidCallback onTap;

  const PriorityNumber({
    super.key,
    required this.number,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64.w,
        height: 64.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandPrimary : AppColors.darkSurface,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconsaxPlusLinear.flag, color: Colors.white),
            SizedBox(height: 5.h),
            Text(
              "$number",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

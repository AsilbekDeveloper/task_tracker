import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

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
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveHelper.wPixel(64),
        height: ResponsiveHelper.hPixel(64),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.black2727,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(IconsaxPlusLinear.flag, color: Colors.white),
            SizedBox(height: ResponsiveHelper.hPixel(5)),
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

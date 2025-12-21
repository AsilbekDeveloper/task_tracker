import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const ButtonWidget({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.wPixel(16),
          vertical: ResponsiveHelper.hPixel(8),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white21,
        ),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const MainButton({
    required this.text,
    required this.onPressed,
    required this.isDisabled,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(double.infinity, ResponsiveHelper.hPixel(48)),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        backgroundColor: WidgetStateProperty.all(
          isDisabled ? AppColors.buttonDefault : AppColors.primaryColor,
        ),
      ),
      child: Text(
        text,
        style:
            isDisabled
                ? AppTextStyles.textButtonDisabled
                : AppTextStyles.textButtonDisabled.copyWith(
                  color: AppColors.whiteColor,
                ),
      ),
    );
  }
}

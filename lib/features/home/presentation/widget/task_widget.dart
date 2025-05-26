import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class TaskWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final DateTime dateTime;
  final String categoryName;
  final Color categoryColor;
  final IconData icon;
  final String priority;
  final bool value;
  final void Function(bool?) onChanged;

  const TaskWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.dateTime,
    required this.categoryName,
    required this.categoryColor,
    required this.icon,
    required this.priority,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: ResponsiveHelper.hPixel(72),
        decoration: BoxDecoration(
          color: AppColors.secondBgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            // left: ResponsiveHelper.wPixel(10),
            right: ResponsiveHelper.wPixel(10),
            top: ResponsiveHelper.hPixel(12),
            bottom: ResponsiveHelper.hPixel(4),
          ),
          child: Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                checkColor: Colors.yellow,
              ),
              // SizedBox(width: ResponsiveHelper.wPixel(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.normal16),
                    // SizedBox(height: ResponsiveHelper.hPixel(6)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            color: const Color(0xFFAFAFAF),
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveHelper.wPixel(8),
                                  vertical: ResponsiveHelper.hPixel(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      icon,
                                      size: 16,
                                      color: AppColors.whiteColor,
                                    ),
                                    SizedBox(width: ResponsiveHelper.wPixel(5)),
                                    Text(
                                      categoryName,
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: ResponsiveHelper.wPixel(12)),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      IconsaxPlusLinear.flag,
                                      size: 16,
                                      color: AppColors.whiteColor,
                                    ),
                                    SizedBox(width: ResponsiveHelper.wPixel(5)),
                                    Text(priority, style: AppTextStyles.normal12),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';

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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 72.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: 10.w,
            top: 12.h,
            bottom: 4.h,
          ),
          child: Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                checkColor: Colors.yellow,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.onSurface),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Category badge
                            Container(
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      IconData(icon.codePoint,
                                          fontFamily: 'MaterialIcons'),
                                      size: 16.w,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      categoryName,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: theme.colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Priority badge
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 1.w,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Icon(
                                      IconsaxPlusLinear.flag,
                                      size: 16.w,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      priority,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: theme.colorScheme.onSurface),
                                    ),
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

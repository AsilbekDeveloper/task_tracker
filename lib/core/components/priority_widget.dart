import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/components/priority_number.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({super.key});

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  int selectedPriority = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        width: 327.w,
        height: 360.h,
        decoration: BoxDecoration(
          color: colorScheme.surface, // Theme-based surface
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Task Priority",
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            ),
            Divider(
              color: colorScheme.outline,
              thickness: 1,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final priority = index + 1;
                  return PriorityNumber(
                    number: priority,
                    isSelected: selectedPriority == priority,
                    onTap: () {
                      setState(() {
                        selectedPriority = priority;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                minimumSize: Size(double.infinity, 48.h),
              ),
              onPressed: () {
                context.pop(selectedPriority);
              },
              child: Text(
                "Save",
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
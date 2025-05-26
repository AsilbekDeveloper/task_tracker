import 'package:flutter/material.dart';
import 'package:task_tracker_app/components/priority_number.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({super.key});

  @override
  State<PriorityWidget> createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  int selectedPriority = 1;

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: ResponsiveHelper.wPixel(327),
        height: ResponsiveHelper.hPixel(360),
        decoration: BoxDecoration(
          color: AppColors.secondBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Task Priority", style: AppTextStyles.bold16),
            const Divider(),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
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
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                minimumSize: Size(double.infinity, ResponsiveHelper.hPixel(48)),
                foregroundColor: AppColors.whiteColor
              ),
              onPressed: () {
                Navigator.pop(context, selectedPriority);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

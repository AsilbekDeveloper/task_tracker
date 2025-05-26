import 'package:flutter/material.dart';
import 'package:task_tracker_app/components/main_button.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class SingleTaskPage extends StatelessWidget {
  final dynamic task;
  final dynamic category;

  const SingleTaskPage({
    super.key,
    required this.task,
    required this.category, required categoryList,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.backgroundColor,
        title: Text(task.title, style: AppTextStyles.medium20),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveHelper.hPixel(15)),
            Text("Task Title", style: AppTextStyles.normal20),
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Text(task.title, style: AppTextStyles.normal16),
            SizedBox(height: ResponsiveHelper.hPixel(8)),
            Divider(),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Text("Task Description", style: AppTextStyles.normal20),
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Text(task.description, style: AppTextStyles.normal16),
            SizedBox(height: ResponsiveHelper.hPixel(8)),
            Divider(),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Text("Task Time", style: AppTextStyles.normal20),
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Text(task.dateTime.toString(), style: AppTextStyles.normal16),
            SizedBox(height: ResponsiveHelper.hPixel(8)),
            Divider(),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Text("Task Category", style: AppTextStyles.normal20),
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Row(
              children: [
                Icon(
                  IconData(category.iconCode, fontFamily: category.fontFamily),
                  color: AppColors.whiteColor,
                ),
                SizedBox(width: ResponsiveHelper.wPixel(10)),
                Text(category.categoryName, style: AppTextStyles.normal16),
              ],
            ),
            SizedBox(height: ResponsiveHelper.hPixel(8)),
            Divider(),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Text("Task Priority", style: AppTextStyles.normal20),
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Text(task.priority.toString(), style: AppTextStyles.normal16),
            SizedBox(height: ResponsiveHelper.hPixel(100)),
            MainButton(
              text: "Edit Task",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.editTaskPage,
                  arguments: {
                    'task': task,
                    'category': category,
                  },
                );

              },
              isDisabled: false,
            ),


          ],
        ),
      ),
    );
  }
}

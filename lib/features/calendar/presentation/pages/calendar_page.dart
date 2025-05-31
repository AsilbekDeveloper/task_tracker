import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: ResponsiveHelper.wPixel(24),
        backgroundColor: AppColors.backgroundColor,
        title: Text("Calendar Page", style: AppTextStyles.normal20,),
      ),
      body: Center(
        child: Text("In progress", style: AppTextStyles.medium20,),
      ),
    );
  }
}

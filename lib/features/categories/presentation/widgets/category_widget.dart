import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final int iconCode;
  final int color;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.iconCode,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Color(color),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconData(iconCode, fontFamily: 'MaterialIcons'),
                  size: 30.w,
                  color: Colors.white,
                ),
                SizedBox(height: 8.h),
                Text(
                  categoryName.isEmpty ? t.home.noName : categoryName,
                  style: TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

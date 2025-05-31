import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final int iconCode;
  final String fontFamily;
  final int color;
  final VoidCallback onPressed;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.iconCode,
    required this.fontFamily,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Color(color),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  IconData(iconCode, fontFamily: fontFamily),
                  size: ResponsiveHelper.wPixel(30),
                  color: Colors.white,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(8)),
                Text(
                  categoryName.isEmpty ? 'No name' : categoryName,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.wPixel(16),
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

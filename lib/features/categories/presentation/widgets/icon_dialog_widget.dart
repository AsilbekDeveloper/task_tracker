import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IconDialogWidget extends StatelessWidget {
  final Function(IconData icon) onIconSelected;

  const IconDialogWidget({
    super.key,
    required this.onIconSelected,
  });

  static const List<IconData> _icons = [
    Icons.work,
    Icons.school,
    Icons.favorite,
    Icons.home,
    Icons.star,
    Icons.sports_soccer,
    Icons.shopping_cart,
    Icons.pets,
    Icons.flight,
    Icons.music_note,
    Icons.book,
    Icons.fitness_center,
    Icons.local_cafe,
    Icons.directions_car,
    Icons.computer,
    Icons.local_hospital,
    Icons.restaurant,
    Icons.beach_access,
    Icons.camera_alt,
    Icons.cleaning_services,
    Icons.lightbulb,
    Icons.phone_android,
    Icons.science,
    Icons.build,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        height: 480.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose an Icon",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 20.h),

            Expanded(
              child: GridView.builder(
                itemCount: _icons.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                ),
                itemBuilder: (context, index) {
                  final icon = _icons[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(50.r),
                    onTap: () {
                      onIconSelected(icon);
                      context.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.surface,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        icon,
                        size: 28.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
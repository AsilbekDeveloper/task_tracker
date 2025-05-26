import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:task_tracker_app/features/categories/presentation/pages/categories_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:task_tracker_app/features/profile/presentation/pages/profile_page.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    CategoriesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: _buildFABForPage(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        color: AppColors.secondBgColor,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: _selectedIndex == 0
                    ? IconsaxPlusBold.home_2
                    : IconsaxPlusLinear.home_2,
                label: "Index",
              ),
              _buildNavItem(
                index: 1,
                icon: _selectedIndex == 1
                    ? IconsaxPlusBold.calendar
                    : IconsaxPlusLinear.calendar,
                label: "Calendar",
              ),
              const SizedBox(width: 40),
              _buildNavItem(
                index: 2,
                icon: _selectedIndex == 2
                    ? IconsaxPlusBold.category
                    : IconsaxPlusLinear.category,
                label: "Category",
              ),
              _buildNavItem(
                index: 3,
                icon: _selectedIndex == 3
                    ? IconsaxPlusBold.user
                    : IconsaxPlusLinear.user,
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildFABForPage(int index) {
    switch (index) {
      case 0: // HomePage
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.addTaskPage);
          },
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.add, color: AppColors.whiteColor),
        );
      case 2: // CategoriesPage
        return FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.createCategoryPage);
          },
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.category, color: AppColors.whiteColor),
        );
      default:
        return null;
    }
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

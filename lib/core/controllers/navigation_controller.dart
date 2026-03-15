import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/categories/presentation/pages/categories_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/calendar_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:task_tracker_app/features/settings/presentation/pages/settings_page.dart';

class NavigationController extends StatefulWidget {
  const NavigationController({super.key});

  @override
  State<NavigationController> createState() => _NavigationControllerState();
}

class _NavigationControllerState extends State<NavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CalendarPage(),
    CategoriesPage(),
    SettingsPage(),
  ];

  bool get _hasFab => _selectedIndex == 0 || _selectedIndex == 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBody: true,
      floatingActionButton: _buildFABForPage(_selectedIndex, theme),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomAppBar(
        shape: _hasFab ? const CircularNotchedRectangle() : null,
        notchMargin: _hasFab ? 6 : 0,
        color: theme.colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                iconSelected: IconsaxPlusBold.home_2,
                iconUnselected: IconsaxPlusLinear.home_2,
                label: "Home",
                theme: theme,
              ),
              _buildNavItem(
                index: 1,
                iconSelected: IconsaxPlusBold.calendar,
                iconUnselected: IconsaxPlusLinear.calendar,
                label: "Calendar",
                theme: theme,
              ),

              if (_hasFab) const SizedBox(width: 40),

              _buildNavItem(
                index: 2,
                iconSelected: IconsaxPlusBold.category,
                iconUnselected: IconsaxPlusLinear.category,
                label: "Category",
                theme: theme,
              ),
              _buildNavItem(
                index: 3,
                iconSelected: IconsaxPlusBold.setting_2,
                iconUnselected: IconsaxPlusLinear.setting_2,
                label: "Settings",
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildFABForPage(int index, ThemeData theme) {
    switch (index) {
      case 0: // Home
        return FloatingActionButton(
          onPressed: () => context.pushNamed(RouteNames.addTask),
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.add, color: theme.colorScheme.onPrimary),
        );
      case 2: // Category
        return FloatingActionButton(
          onPressed: () => context.pushNamed(RouteNames.createCategory),
          backgroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.category, color: theme.colorScheme.onPrimary),
        );
      default:
        return null;
    }
  }

  Widget _buildNavItem({
    required int index,
    required IconData iconSelected,
    required IconData iconUnselected,
    required String label,
    required ThemeData theme,
  }) {
    final isSelected = _selectedIndex == index;
    final iconColor = isSelected
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withOpacity(0.5);
    final textColor = isSelected
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withOpacity(0.5);

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isSelected ? iconSelected : iconUnselected, color: iconColor),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: textColor, fontSize: 12)),
        ],
      ),
    );
  }
}

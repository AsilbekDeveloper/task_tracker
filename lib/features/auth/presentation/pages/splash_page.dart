import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final box = await Hive.openBox('userBox');
    final String? uid = box.get('uid');

    final currentUser = FirebaseAuth.instance.currentUser;

    if (uid != null && currentUser != null && uid == currentUser.uid) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.bottomNavbar);
      }
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.signInPage);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.appLogo),
            SizedBox(height: ResponsiveHelper.hPixel(20)),
            Text(
              "TaskTracker",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: ResponsiveHelper.wPixel(40),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

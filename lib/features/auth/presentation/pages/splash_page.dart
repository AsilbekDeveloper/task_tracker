import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/router/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const _boxName = 'userBox';
  static const _uidKey = 'uid';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    final box =
        Hive.isBoxOpen(_boxName)
            ? Hive.box(_boxName)
            : await Hive.openBox(_boxName);

    final storedUid = box.get(_uidKey) as String?;
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    final isLoggedIn =
        storedUid != null &&
        firebaseUser != null &&
        storedUid == firebaseUser.uid;

    context.goNamed(isLoggedIn ? RouteNames.bottomNavbar : RouteNames.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.appLogo),
            SizedBox(height: 20.h),
            Text(
              "TaskTracker",
              style: AppTextStyles.displayLarge.copyWith(
                fontSize: 40,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

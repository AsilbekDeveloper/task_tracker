import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/components/setting_group_widget.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.secondBgColor,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.task_square),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.user),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: ResponsiveHelper.hPixel(100),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.wPixel(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: ResponsiveHelper.hPixel(35)),
                Text("Profile", style: AppTextStyles.normal20),
                SizedBox(height: ResponsiveHelper.hPixel(24)),
                Image.asset(AppImages.profileImage),
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                Text("Martha Hays", style: AppTextStyles.medium20),
                SizedBox(height: ResponsiveHelper.hPixel(20)),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.wPixel(34),
                        vertical: ResponsiveHelper.hPixel(17),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "10 Tasks left",
                        style: AppTextStyles.normal16,
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.wPixel(20)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.wPixel(34),
                        vertical: ResponsiveHelper.hPixel(17),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "5 Tasks left",
                        style: AppTextStyles.normal16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(32)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: AppColors.greyAF,
                        fontSize: ResponsiveHelper.wPixel(14),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(16)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.setting_2,
                      text: "App Settings",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(32)),
                    Text(
                      "Account",
                      style: TextStyle(
                        color: AppColors.greyAF,
                        fontSize: ResponsiveHelper.wPixel(14),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(16)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.user,
                      text: "Change account name",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.key,
                      text: "Change account password",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.camera,
                      text: "Change account Image",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(32)),
                    Text(
                      "Uptodo",
                      style: TextStyle(
                        color: AppColors.greyAF,
                        fontSize: ResponsiveHelper.wPixel(14),
                      ),
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(16)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.menu_1,
                      text: "About US",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.info_circle,
                      text: "FAQ",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.flash_1,
                      text: "Help & Feedback",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    SettingGroupWidget(
                      icon: IconsaxPlusLinear.like_1,
                      text: "Support US",
                      onPressed: () {},
                    ),
                    SizedBox(height: ResponsiveHelper.hPixel(24)),
                    BlocConsumer<SignOutBloc, SignOutState>(
                      listener: (context, state) {
                        if (state is SignOutSuccess) {
                          Navigator.of(context).pushReplacementNamed(RouteNames.signInPage);
                        }
                        if (state is SignOutError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is SignOutLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.redColor,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<SignOutBloc>().add(SignOutEvent());
                          },
                          child: Row(
                            children: [
                              Icon(
                                IconsaxPlusLinear.logout,
                                color: AppColors.redColor,
                              ),
                              SizedBox(width: ResponsiveHelper.wPixel(10)),
                              Text(
                                "Log out",
                                style: TextStyle(
                                  color: AppColors.redColor,
                                  fontSize: ResponsiveHelper.wPixel(16),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

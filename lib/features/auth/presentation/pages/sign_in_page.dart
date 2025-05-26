import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_tracker_app/components/main_button.dart';
import 'package:task_tracker_app/components/social_button_widget.dart';
import 'package:task_tracker_app/components/text_field_widget.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/strings/app_string.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool buttonState = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkForm);
    passwordController.addListener(_checkForm);
  }

  void _checkForm() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      buttonState = email.isNotEmpty && password.isNotEmpty;
    });
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) async {
        if (state is SignInSuccess) {
          final box = await Hive.openBox('userBox');
          await box.put('uid', FirebaseAuth.instance.currentUser?.uid);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.bottomNavbar,
                (route) => false,
          );
        } else if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(backgroundColor: AppColors.backgroundColor),
            backgroundColor: AppColors.backgroundColor,
            body:
                state is SignInLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.wPixel(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: ResponsiveHelper.hPixel(20)),
                          Text(AppString.login, style: AppTextStyles.bold32),
                          SizedBox(height: ResponsiveHelper.hPixel(53)),
                          Text(
                            AppString.email,
                            style: AppTextStyles.normal16,
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(8)),
                          TextFieldWidget(
                            controller: emailController,
                            text: AppString.enterEmail,
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(25)),
                          Text(
                            AppString.password,
                            style: AppTextStyles.normal16,
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(8)),
                          TextFieldWidget(
                            controller: passwordController,
                            text: AppString.enterPassword,
                            isPassword: true,
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(69)),
                          MainButton(
                            text: AppString.login,
                            onPressed: () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Email va parol bo‘sh bo‘lmasligi kerak",
                                    ),
                                  ),
                                );
                                return;
                              }
                              context.read<SignInBloc>().add(
                                SignInEvent(email: email, password: password),
                              );
                            },
                            isDisabled: !buttonState,
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(31)),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  AppString.or,
                                  style: TextStyle(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: AppColors.borderColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(29)),
                          SocialButtonWidget(
                            logoPath: AppImages.google,
                            text: AppString.loginGoogle,
                            onTap: () {},
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(20)),
                          SocialButtonWidget(
                            logoPath: AppImages.apple,
                            text: AppString.loginApple,
                            onTap: () {},
                          ),
                          SizedBox(height: ResponsiveHelper.hPixel(40)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppString.dontHaveAccount,
                                style: AppTextStyles.regularText2,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RouteNames.signUpPage);
                                },
                                child: Text(
                                  AppString.register,
                                  style: AppTextStyles.normal12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
          ),
        );
      },
    );
  }
}

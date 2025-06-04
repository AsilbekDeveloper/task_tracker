import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool buttonState = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkForm);
    passwordController.addListener(_checkForm);
    confirmPasswordController.addListener(_checkForm);
  }

  void _checkForm() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    setState(() {
      buttonState = email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;
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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushNamed(context, RouteNames.signInPage);
        } else if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(backgroundColor: AppColors.backgroundColor),
          backgroundColor: AppColors.backgroundColor,
          body:
          state is SignUpLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.wPixel(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SizedBox(height: ResponsiveHelper.hPixel(6)),
                Text(AppString.register, style: AppTextStyles.bold32),
                SizedBox(height: ResponsiveHelper.hPixel(23)),
                Text(
                  AppString.email,
                  style: AppTextStyles.normal16,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(8)),
                TextFieldWidget(
                  key: const Key('signUpEmailField'),
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
                  key: const Key('signUpPasswordField'),
                  controller: passwordController,
                  text: AppString.enterPassword,
                  isPassword: true,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(25)),
                Text(
                  AppString.confirmPassword,
                  style: AppTextStyles.normal16,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(8)),
                TextFieldWidget(
                  key: const Key('signUpConfirmPasswordField'),
                  controller: confirmPasswordController,
                  text: AppString.confirmYourPassword,
                  isPassword: true,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(40)),
                MainButton(
                  key: const Key('signUpButton'),
                  text: AppString.register,
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }
                    context.read<SignUpBloc>().add(SignUpEvent(email: email, password: password),);
                  },
                  isDisabled: !buttonState,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(18)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.borderColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.wPixel(5),
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
                  text: AppString.registerGoogle,
                  onTap: () {},
                ),
                SizedBox(height: ResponsiveHelper.hPixel(20)),
                SocialButtonWidget(
                  logoPath: AppImages.apple,
                  text: AppString.registerApple,
                  onTap: () {},
                ),
                SizedBox(height: ResponsiveHelper.hPixel(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.alreadyHaveAccount,
                      style: AppTextStyles.regularText2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.signInPage);
                      },
                      child: Text(
                        AppString.login,
                        style: AppTextStyles.normal12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/components/social_button_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart'; // <- Slang

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context.goNamed(RouteNames.bottomNavbar);
            }
            if (state is SignInError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
        BlocListener<GoogleSignInBloc, GoogleSignInState>(
          listener: (context, state) {
            if (state is GoogleSignInSuccess) {
              context.goNamed(RouteNames.bottomNavbar);
            }
            if (state is GoogleSignInError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
              ),
              body:
                  state is SignInLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Text(
                              t.auth.login,
                              style: AppTextStyles.displayLarge.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Text(t.auth.email, style: AppTextStyles.bodyLarge),
                            SizedBox(height: 8.h),
                            TextFieldWidget(
                              controller: emailController,
                              text: t.auth.enterEmail,
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              t.auth.password,
                              style: AppTextStyles.bodyLarge,
                            ),
                            SizedBox(height: 8.h),
                            TextFieldWidget(
                              controller: passwordController,
                              text: t.auth.enterPassword,
                              isPassword: true,
                            ),
                            SizedBox(height: 65.h),
                            MainButton(
                              text: t.auth.login,
                              onPressed: () {
                                context.read<SignInBloc>().add(
                                  SignInEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 40.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.h,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Text(
                                    t.auth.or,
                                    style: TextStyle(
                                      color: AppColors.darkBorder,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1.h,
                                    color: AppColors.darkBorder,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                            BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
                              builder: (context, gState) {
                                return SocialButtonWidget(
                                  logoPath: AppImages.google,
                                  text: t.auth.loginGoogle,
                                  onTap: () {
                                    context.read<GoogleSignInBloc>().add(
                                      GoogleSignInPressed(),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  t.auth.dontHaveAccount,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      () =>
                                          context.pushNamed(RouteNames.signUp),
                                  child: Text(
                                    t.auth.register,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
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
      ),
    );
  }
}

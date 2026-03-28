import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/components/social_button_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
  }

  void _checkFields() {
    final enabled =
        _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;

    if (_isButtonEnabled != enabled) {
      setState(() => _isButtonEnabled = enabled);
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkFields);
    _passwordController.removeListener(_checkFields);

    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<SignInBloc>().add(
      SignInEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
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
            if (state is SignInError &&
                state.fieldError == SignInFieldError.none) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<GoogleSignInBloc, GoogleSignInState>(
          listener: (context, state) {
            if (state is GoogleSignInSuccess) {
              context.goNamed(RouteNames.bottomNavbar);
            }
            if (state is GoogleSignInError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          final emailError = (state is SignInError &&
              state.fieldError == SignInFieldError.email)
              ? state.message
              : null;

          final passwordError = (state is SignInError &&
              state.fieldError == SignInFieldError.password)
              ? state.message
              : null;

          final isLoading = state is SignInLoading;

          return SafeArea(
            child: Scaffold(
              backgroundColor: colorScheme.surface,
              appBar: AppBar(
                backgroundColor: colorScheme.surface,
                elevation: 0,
              ),
              body: isLoading
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
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    /// Email
                    Text(
                      t.auth.email,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFieldWidget(
                      controller: _emailController,
                      text: t.auth.enterEmail,
                      inputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      errorText: emailError,
                    ),

                    SizedBox(height: 25.h),

                    /// Password
                    Text(
                      t.auth.password,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFieldWidget(
                      controller: _passwordController,
                      text: t.auth.enterPassword,
                      isPassword: true,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _submit,
                      errorText: passwordError,
                    ),

                    SizedBox(height: 45.h),

                    /// Login button
                    MainButton(
                      text: t.auth.login,
                      onPressed: (_isButtonEnabled && !isLoading) ? _submit : null,
                    ),

                    SizedBox(height: 40.h),

                    /// Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1.h,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            t.auth.or,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.h,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    /// Google sign in
                    BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
                      builder: (context, gState) {
                        return SocialButtonWidget(
                          logoPath: AppImages.google,
                          text: t.auth.loginGoogle,
                          onTap: () => context
                              .read<GoogleSignInBloc>()
                              .add(GoogleSignInPressed()),
                        );
                      },
                    ),

                    SizedBox(height: 25.h),

                    /// Register link
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
                          onPressed: () =>
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/components/social_button_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/core/di/service_locator.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_state.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignUpBloc>(),
      child: const _SignUpBody(),
    );
  }
}

class _SignUpBody extends StatefulWidget {
  const _SignUpBody();

  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmFocusNode = FocusNode();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
    _confirmController.addListener(_checkFields);
  }

  void _checkFields() {
    final enabled =
        _emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _confirmController.text.isNotEmpty;

    if (_isButtonEnabled != enabled) {
      setState(() => _isButtonEnabled = enabled);
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkFields);
    _passwordController.removeListener(_checkFields);
    _confirmController.removeListener(_checkFields);
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  // UI faqat event yuboradi — barcha logika Bloc da
  void _submit() {
    FocusScope.of(context).unfocus();
    context.read<SignUpBloc>().add(
      SignUpEvent(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              context.goNamed(RouteNames.signIn);
            }
            if (state is SignUpError) {
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
        // GoogleSignInBloc main.dart da — listen qilish mumkin
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
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          final isLoading = state is SignUpLoading;

          return Scaffold(
            appBar: AppBar(elevation: 0),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  Text(
                    t.auth.register,
                    style: textTheme.displayLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  /// Email
                  Text(
                    t.auth.email,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFieldWidget(
                    controller: _emailController,
                    text: t.auth.enterEmail,
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                  ),

                  SizedBox(height: 24.h),

                  /// Password
                  Text(
                    t.auth.password,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFieldWidget(
                    controller: _passwordController,
                    text: t.auth.enterPassword,
                    isPassword: true,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_confirmFocusNode),
                  ),

                  SizedBox(height: 24.h),

                  /// Confirm password
                  Text(
                    t.auth.confirmPassword,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFieldWidget(
                    controller: _confirmController,
                    text: t.auth.confirmYourPassword,
                    isPassword: true,
                    focusNode: _confirmFocusNode,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _submit,
                  ),

                  SizedBox(height: 32.h),

                  /// Register button
                  MainButton(
                    text: isLoading ? t.task.loading : t.auth.register,
                    onPressed: (_isButtonEnabled && !isLoading) ? _submit : null,
                  ),

                  SizedBox(height: 24.h),

                  /// Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: colorScheme.onSurfaceVariant),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          t.auth.or,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// Google register
                  SocialButtonWidget(
                    logoPath: AppImages.google,
                    text: t.auth.registerGoogle,
                    onTap: () => context
                        .read<GoogleSignInBloc>()
                        .add(GoogleSignInPressed()),
                  ),

                  SizedBox(height: 24.h),

                  /// Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.auth.alreadyHaveAccount,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.goNamed(RouteNames.signIn),
                        child: Text(
                          t.auth.login,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
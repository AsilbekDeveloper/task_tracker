import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/components/social_button_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_state.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFields);
    _passwordController.addListener(_checkFields);
    _confirmController.addListener(_checkFields);
  }

  void _checkFields() {
    final enabled = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmController.text.isNotEmpty;

    if (_isButtonEnabled != enabled) {
      setState(() => _isButtonEnabled = enabled);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    context.read<SignUpBloc>().add(
      SignUpEvent(
        email: email,
        password: password,
        confirmPassword: confirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                context.goNamed(RouteNames.signIn);
              } else if (state is SignUpError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
          BlocListener<GoogleSignInBloc, GoogleSignInState>(
            listener: (context, state) {
              if (state is GoogleSignInSuccess) {
                context.goNamed(RouteNames.bottomNavbar);
              } else if (state is GoogleSignInError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Title
              Text(
                t.auth.register,
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),

              SizedBox(height: 30.h),

              // Email field
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
              ),

              SizedBox(height: 24.h),

              // Password field
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
              ),

              SizedBox(height: 24.h),

              // Confirm password
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
              ),

              SizedBox(height: 32.h),

              // Main Button
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  final isLoading = state is SignUpLoading;

                  return MainButton(
                    text: isLoading ? "Loading..." : t.auth.register,
                    onPressed:
                    (_isButtonEnabled && !isLoading) ? _submit : null,
                  );
                },
              ),

              SizedBox(height: 24.h),

              // Or Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(color: colorScheme.outline),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      t.auth.or,
                      style: textTheme.displayLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: colorScheme.outline),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Social login
              SocialButtonWidget(
                logoPath: AppImages.google,
                text: t.auth.registerGoogle,
                onTap: () {
                  context.read<GoogleSignInBloc>().add(GoogleSignInPressed());
                },
              ),

              SizedBox(height: 24.h),

              // Already have account
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.auth.alreadyHaveAccount,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(RouteNames.signIn),
                      child: Text(
                        t.auth.login,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
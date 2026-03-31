import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/core/theme/theme_bloc.dart';
import 'package:task_tracker_app/core/theme/theme_event.dart';
import 'package:task_tracker_app/core/theme/theme_state.dart';
import 'package:task_tracker_app/core/utils/language_service.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          t.home.settings,
          style: AppTextStyles.headlineMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.settings.selectLanguage,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: _languageButton(
                      context,
                      label: "English",
                      locale: AppLocale.en,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _languageButton(
                      context,
                      label: "Русский",
                      locale: AppLocale.ru,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _languageButton(
                      context,
                      label: "O'zbek",
                      locale: AppLocale.uz,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              Text(
                t.settings.theme,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 16.h),

              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  final isDark = state.themeMode == ThemeMode.dark;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDark ? t.settings.darkMode : t.settings.lightMode,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Switch(
                        value: isDark,
                        onChanged: (value) {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(
                              value ? ThemeMode.dark : ThemeMode.light,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 40.h),
              BlocConsumer<SignOutBloc, SignOutState>(
                listener: (context, state) {
                  if (state is SignOutSuccess) {
                    context.goNamed(RouteNames.signIn);
                  }
                  if (state is SignOutError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  final isLoading = state is SignOutLoading;

                  return GestureDetector(
                    onTap:
                        isLoading
                            ? null
                            : () {
                              context.read<SignOutBloc>().add(SignOutEvent());
                            },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        isLoading
                            ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                            : Icon(
                              IconsaxPlusLinear.logout,
                              color: colorScheme.error,
                            ),
                        SizedBox(width: 10.w),
                        Text(
                          t.logout,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageButton(
    BuildContext context, {
    required String label,
    required AppLocale locale,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentLocale = TranslationProvider.of(context).locale;
    final isSelected = currentLocale == locale;

    return GestureDetector(
      onTap: () async => await LanguageService.changeLanguage(locale),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          border: Border.all(color: colorScheme.primary, width: 1.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

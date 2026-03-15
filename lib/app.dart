import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_tracker_app/core/router/app_router.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/core/theme/theme_bloc.dart';
import 'package:task_tracker_app/core/theme/theme_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              routerConfig: appRouter,
              title: 'Task Tracker',
              debugShowCheckedModeBanner: false,

              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
            );
          },
        );
      },
    );
  }
}

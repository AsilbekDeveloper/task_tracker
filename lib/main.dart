import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:task_tracker_app/app.dart';
import 'package:task_tracker_app/core/di/service_locator.dart';
import 'package:task_tracker_app/core/theme/theme_bloc.dart';
import 'package:task_tracker_app/core/theme/theme_event.dart';
import 'package:task_tracker_app/core/utils/language_service.dart';
import 'package:task_tracker_app/firebase_options.dart';

import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in_with_google/google_sign_in_bloc.dart';

import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_bloc.dart';

import 'package:task_tracker_app/features/home/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await setup();
  LocaleSettings.useDeviceLocale();
  LanguageService.init();

  runApp(
    TranslationProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<ThemeBloc>()..add(LoadThemeEvent()),
          ),
          BlocProvider(create: (_) => sl<SignOutBloc>()),
          BlocProvider(create: (_) => sl<GoogleSignInBloc>()),

          BlocProvider(create: (_) => sl<CategoryListBloc>()),
          BlocProvider(create: (_) => sl<DeleteCategoryBloc>()),

          BlocProvider(create: (_) => sl<GetAllTasksBloc>()),
          BlocProvider(create: (_) => sl<CreateTaskBloc>()),
          BlocProvider(create: (_) => sl<EditTaskBloc>()),
          BlocProvider(create: (_) => sl<DeleteTaskBloc>()),
          BlocProvider(create: (_) => sl<UpdateTaskBloc>()),
          BlocProvider(create: (_) => sl<SelectedDateBloc>()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
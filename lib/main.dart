import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_tracker_app/app.dart';
import 'package:task_tracker_app/core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setup();
  await Hive.initFlutter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SignInBloc>()),
        BlocProvider(create: (context) => sl<SignUpBloc>()),
        BlocProvider(create: (context) => sl<CategoryListBloc>()),
        BlocProvider(create: (context) => sl<CreateCategoryBloc>()),
        BlocProvider(create: (context) => sl<GetAllTasksBloc>()),
        BlocProvider(create: (context) => sl<CreateTaskBloc>()),
        BlocProvider(create: (context) => sl<EditTaskBloc>()),
        BlocProvider(create: (context) => sl<DeleteTaskBloc>()),
        BlocProvider(create: (context) => sl<DeleteCategoryBloc>()),
        BlocProvider(create: (context) => sl<SignOutBloc>()),
      ],
      child: MyApp(),
    ),
  );
}



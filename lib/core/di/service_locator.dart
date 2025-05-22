import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:task_tracker_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_tracker_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:task_tracker_app/features/categories/data/data_source/categories_remote_data_source.dart';
import 'package:task_tracker_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/categories_list_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/create_category_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_bloc.dart';
import 'package:task_tracker_app/features/home/data/data_source/task_remote_data_source.dart';
import 'package:task_tracker_app/features/home/data/repositories/task_repository_impl.dart';
import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/create_task_use_case.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/delete_task_use_case.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/edit_task_use_case.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Registering Firebase services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // RemoteDataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<CategoriesRemoteDataSource>(() => CategoriesRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton<CategoryListUseCase>(() => CategoryListUseCase(sl()));
  sl.registerLazySingleton<CreateCategoryUseCase>(() => CreateCategoryUseCase(categoryRepository: sl()));
  sl.registerLazySingleton<AddDefaultCategoriesUseCase>(() => AddDefaultCategoriesUseCase(sl()));
  sl.registerLazySingleton<GetAllTasksUseCase>(() =>GetAllTasksUseCase(sl()));
  sl.registerLazySingleton<CreateTaskUseCase>(() =>CreateTaskUseCase(sl()));
  sl.registerLazySingleton<EditTaskUseCase>(() =>EditTaskUseCase(sl()));
  sl.registerLazySingleton<DeleteTaskUseCase>(() =>DeleteTaskUseCase(sl()));

  // BLoCs
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory<SignInBloc>(() => SignInBloc(signInUseCase: sl()));
  sl.registerFactory<CategoryListBloc>(() => CategoryListBloc(categoryListUseCase: sl(), addDefaultCategoriesUseCase: sl(),));
  sl.registerFactory<CreateCategoryBloc>(() => CreateCategoryBloc(createCategoryUseCase: sl()));
  sl.registerFactory<GetAllTasksBloc>(() => GetAllTasksBloc(getAllTasksUseCase: sl()));
  sl.registerFactory<CreateTaskBloc>(() => CreateTaskBloc(createTaskUseCase: sl()));
  sl.registerFactory<EditTaskBloc>(() => EditTaskBloc(editTaskUseCase: sl()));
  sl.registerFactory<DeleteTaskBloc>(() => DeleteTaskBloc(deleteTaskUseCase: sl()));
}

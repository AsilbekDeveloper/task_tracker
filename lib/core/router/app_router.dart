import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/controllers/navigation_controller.dart';
import 'package:task_tracker_app/core/router/route_names.dart';

import 'package:task_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:task_tracker_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:task_tracker_app/features/auth/presentation/pages/splash_page.dart';

import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/categories/presentation/pages/categories_page.dart';
import 'package:task_tracker_app/features/categories/presentation/pages/create_category_page.dart';
import 'package:task_tracker_app/features/categories/presentation/pages/single_category_page.dart';

import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/pages/add_task_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/edit_task_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:task_tracker_app/features/home/presentation/pages/single_task_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.splash,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: RouteNames.signUp,
      builder: (_, __) => const SignUpPage(),
    ),
    GoRoute(
      path: '/sign-in',
      name: RouteNames.signIn,
      builder: (_, __) => const SignInPage(),
    ),
    GoRoute(
      path: '/home',
      name: RouteNames.home,
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/categories',
      name: RouteNames.categories,
      builder: (_, __) => CategoriesPage(),
    ),
    GoRoute(
      path: '/bottom-navbar',
      name: RouteNames.bottomNavbar,
      builder: (_, __) => NavigationController(),
    ),
    GoRoute(
      path: '/categories/create',
      name: RouteNames.createCategory,
      builder: (_, __) => CreateCategoryPage(),
    ),
    GoRoute(
      path: '/categories/:id',
      name: RouteNames.singleCategory,
      builder: (context, state) {
        final categoryId = state.pathParameters['id']!;
        final categoryName = state.uri.queryParameters['name']!;
        return SingleCategoryPage(
          categoryId: categoryId,
          categoryName: categoryName,
        );
      },
    ),
    GoRoute(
      path: '/tasks/create',
      name: RouteNames.addTask,
      builder: (_, __) => AddTaskPage(),
    ),

    GoRoute(
      path: '/tasks/:id',
      name: RouteNames.singleTask,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return SingleTaskPage(
          task: extra['task'] as TaskEntity,
          category: extra['category'] as CategoryModel,
        );
      },
    ),

    GoRoute(
      path: '/tasks/:id/edit',
      name: RouteNames.editTask,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return EditTaskPage(
          task: extra['task'] as TaskEntity,
          category: extra['category'] as CategoryModel,
        );
      },
    ),
  ],
);

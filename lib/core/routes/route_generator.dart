import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/controllers/navigation_controller.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
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

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteNames.signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.categoriesPage:
        return MaterialPageRoute(builder: (_) => CategoriesPage());
      case RouteNames.groupPage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.bottomNavbar:
        return MaterialPageRoute(builder: (_) => NavigationController());
      case RouteNames.createCategoryPage:
        return MaterialPageRoute(builder: (_) => CreateCategoryPage());
      case RouteNames.addTaskPage:
        return MaterialPageRoute(builder: (_) => AddTaskPage());
      case RouteNames.singleTaskPage:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SingleTaskPage(
            task: args['task'],
            category: args['category'],
            categoryList: args['categoryList'],
          ),
        );


      case RouteNames.singleCategoryPage:
        final args = routeSettings.arguments as Map<String, String>;
        final categoryId = args['categoryId']!;
        final categoryName = args['categoryName']!;
        return MaterialPageRoute(
          builder:
              (_) => SingleCategoryPage(
                categoryId: categoryId,
                categoryName: categoryName,
              ),
        );
      case RouteNames.editTaskPage:
        final args = routeSettings.arguments as Map<String, dynamic>;
        final task = args['task'] as TaskEntity;
        final category = args['category'] as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => EditTaskPage(task: task, category: category),
        );

      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}

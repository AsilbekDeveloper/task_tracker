import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/routes/route_generator.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.signInPage,
      onGenerateRoute: AppRoute(context: context).onGenerateRoute,
    );
  }
}
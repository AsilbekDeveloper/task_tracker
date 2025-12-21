import 'package:flutter/material.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';

class CreateCategory extends CategoriesEvent {
  final String name;
  final IconData icon;
  final Color color;

  const CreateCategory({
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  List<Object?> get props => [name, icon, color];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CreateCategoryEvent extends Equatable {
  const CreateCategoryEvent();

  @override
  List<Object?> get props => [];
}

class CreateCategory extends CreateCategoryEvent {
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

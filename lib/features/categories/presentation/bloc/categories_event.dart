import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class CategoryListEvent extends CategoriesEvent {
  final String userId;

  const CategoryListEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateCategoryEvent extends CategoriesEvent {
  final String userId;
  final String categoryName;
  final IconData icon;
  final Color color;

  const CreateCategoryEvent({
    required this.userId,
    required this.categoryName,
    required this.icon,
    required this.color,
  });

  @override
  List<Object> get props => [
    userId,
    categoryName,
    icon.codePoint,
    icon.fontFamily ?? '',
    color.value,
  ];
}

class DeleteCategoryEvent extends CategoriesEvent {
   final String categoryId;

  const DeleteCategoryEvent({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class AddDefaultCategoriesEvent extends CategoriesEvent {
  final String userId;

  const AddDefaultCategoriesEvent({required this.userId});
}

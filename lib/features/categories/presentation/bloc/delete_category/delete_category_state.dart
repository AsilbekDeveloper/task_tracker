import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';

abstract class DeleteCategoryState extends Equatable {
  const DeleteCategoryState();

  @override
  List<Object?> get props => [];
}

class DeleteCategoryInitial extends DeleteCategoryState {}

class DeleteCategoryLoading extends DeleteCategoryState {}

class DeleteCategorySuccess extends DeleteCategoryState {
  final String categoryId;

  const DeleteCategorySuccess(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class DeleteCategoryError extends DeleteCategoryState {
  final String errorMessage;

  const DeleteCategoryError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
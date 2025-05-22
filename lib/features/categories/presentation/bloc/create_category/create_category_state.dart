import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';

abstract class CreateCategoryState extends Equatable {
  const CreateCategoryState();

  @override
  List<Object?> get props => [];
}

class CreateCategoryInitial extends CreateCategoryState {}

class CreateCategoryLoading extends CreateCategoryState {}

class CreateCategorySuccess extends CreateCategoryState {
  final CategoryEntity newCategory;

  const CreateCategorySuccess(this.newCategory);

  @override
  List<Object?> get props => [newCategory];
}

class CreateCategoryError extends CreateCategoryState {
  final String errorMessage;

  const CreateCategoryError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
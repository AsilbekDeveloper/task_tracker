import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();

  @override
  List<Object?> get props => [];
}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListSuccess extends CategoryListState {
  final CategoryListEntity categoryList;

  const CategoryListSuccess(this.categoryList);

  @override
  List<Object?> get props => [categoryList];
}

class CategoryListError extends CategoryListState {
  final String errorMessage;

  const CategoryListError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
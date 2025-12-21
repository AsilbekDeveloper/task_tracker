import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';


class CategoryListEntity extends Equatable {
  final List<CategoryEntity> categoryList;

  const CategoryListEntity({required this.categoryList});

  @override
  List<Object?> get props => [categoryList];
}

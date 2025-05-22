import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';

class CategoryListModel extends CategoryListEntity {
  CategoryListModel({required super.categories});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    final categoryList = (json['categories'] as List)
        .map((categoryJson) {

      return CategoryEntity(
        categoryId: categoryJson['categoryId'] ?? '',
        categoryName: categoryJson['name'] ?? '',
        userId: categoryJson['userId'] ?? '',
        iconCode: categoryJson['iconCode'] ?? 0,
        fontFamily: categoryJson['fontFamily'] ?? '',
        color: categoryJson['color'] ?? 0,
      );
    }).toList();

    return CategoryListModel(categories: categoryList);
  }
  Map<String, dynamic> toJson() {
    return {
      'categories': categories
          .map((category) => {
        'categoryId': category.categoryId,
        'name': category.categoryName,
        'userId': category.userId,
        'iconCode': category.iconCode,
        'fontFamily': category.fontFamily,
      })
          .toList(),
    };
  }
}

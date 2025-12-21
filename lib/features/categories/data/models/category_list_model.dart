import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';

class CategoryListModel extends CategoryListEntity {
  const CategoryListModel({required super.categoryList});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    final categoryList = (json['categories'] as List).map((categoryJson) {

      return CategoryEntity(
        categoryId: categoryJson['categoryId'] ?? '',
        categoryName: categoryJson['name'] ?? '',
        userId: categoryJson['userId'] ?? '',
        iconCode: categoryJson['iconCode'] ?? 0,
        color: categoryJson['color'] ?? 0,
      );
    }).toList();

    return CategoryListModel(categoryList: categoryList);
  }
  Map<String, dynamic> toJson() {
    return {
      'categories': categoryList
          .map((category) => {
        'categoryId': category.categoryId,
        'name': category.categoryName,
        'userId': category.userId,
        'iconCode': category.iconCode,
      })
          .toList(),
    };
  }
}

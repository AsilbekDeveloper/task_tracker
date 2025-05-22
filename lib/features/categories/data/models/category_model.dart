import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.categoryId,
    required super.categoryName,
    required super.userId,
    required super.iconCode,
    required super.fontFamily,
    required super.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      categoryId: id,
      categoryName: json['name'] ?? '',
      userId: json['userId'] ?? '',
      iconCode: json['iconCode'] ?? 0,
      fontFamily: json['fontFamily'] ?? '',
      color: json['color'] ?? 0xFF000000,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': categoryName,
      'userId': userId,
      'iconCode': iconCode,
      'fontFamily': fontFamily,
      'color': color,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
      userId: userId,
      iconCode: iconCode,
      fontFamily: fontFamily,
      color: color,
    );
  }

}

import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import '../entities/category_list_entity.dart';

abstract class CategoriesRepository {
  Future<CategoryListEntity> getCategoryList({required String userId});

  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required String? fontFamily,
    required int color,
  });

  Future<void> addDefaultCategoriesForUser(String userId);
}
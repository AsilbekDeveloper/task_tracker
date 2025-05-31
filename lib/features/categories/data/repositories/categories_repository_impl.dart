import 'package:task_tracker_app/features/categories/data/data_source/categories_remote_data_source.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepositoryImpl(this.categoriesRemoteDataSource);

  @override
  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required String? fontFamily,
    required int color,
  }) {
    return categoriesRemoteDataSource.createCategory(
      categoryName: categoryName,
      userId: userId,
      iconCode: iconCode,
      fontFamily: fontFamily,
      color: color,
    );
  }

  @override
  Future<CategoryListEntity> getCategoryList({required String userId}) {
    return categoriesRemoteDataSource.getCategoryList(userId: userId);
  }

  @override
  Future<void> addDefaultCategoriesForUser(String userId) {
    return categoriesRemoteDataSource.addDefaultCategoriesForUser(userId);
  }

  @override
  Future<void> deleteCategory({required String categoryId}) {
    return categoriesRemoteDataSource.deleteCategory(categoryId: categoryId);
  }
}
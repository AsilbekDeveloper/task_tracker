import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class EditCategoryUseCase {
  final CategoriesRepository categoryRepository;

  EditCategoryUseCase({required this.categoryRepository});

  Future<CategoryEntity> call({
    required String categoryName,
    required int iconCode,
    required int color,
    required String categoryId
  }) {
    return categoryRepository.editCategory(
      categoryName: categoryName,
      iconCode: iconCode,
      color: color,
      categoryId: categoryId,
    );
  }
}

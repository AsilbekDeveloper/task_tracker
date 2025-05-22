import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class CreateCategoryUseCase {
  final CategoriesRepository categoryRepository;

  CreateCategoryUseCase({required this.categoryRepository});

  Future<CategoryEntity> call({
    required String categoryName,
    required String userId,
    required int iconCode,
    required String? fontFamily,
    required int color,
  }) {
    return categoryRepository.createCategory(
      categoryName: categoryName,
      userId: userId,
      iconCode: iconCode,
      fontFamily: fontFamily,
      color: color,
    );
  }
}

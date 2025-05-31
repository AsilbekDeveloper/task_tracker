import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class DeleteCategoryUseCase {
  final CategoriesRepository categoriesRepository;

  DeleteCategoryUseCase(this.categoriesRepository);

  Future<void> call({required String categoryId}) {
    return categoriesRepository.deleteCategory(categoryId: categoryId);
  }
}


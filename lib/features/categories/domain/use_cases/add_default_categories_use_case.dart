import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class AddDefaultCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  AddDefaultCategoriesUseCase(this.categoriesRepository);

  Future<void> call(String userId) {
    return categoriesRepository.addDefaultCategoriesForUser(userId);
  }
}

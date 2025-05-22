import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';
import 'package:task_tracker_app/features/categories/domain/repositories/categories_repository.dart';

class CategoryListUseCase {
  final CategoriesRepository categoriesRepository;

  CategoryListUseCase(this.categoriesRepository);

  Future<CategoryListEntity> call({required String userid}) {
    return categoriesRepository.getCategoryList(userId: userid);
  }
}


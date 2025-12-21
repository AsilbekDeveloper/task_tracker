import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';

class DeleteCategory extends CategoriesEvent {
  final String categoryId;

  const DeleteCategory({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

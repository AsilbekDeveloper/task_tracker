import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/categories_list_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';

class CategoryListBloc extends Bloc<CategoriesEvent, CategoryListState> {
  final CategoryListUseCase categoryListUseCase;
  final AddDefaultCategoriesUseCase addDefaultCategoriesUseCase;

  CategoryListBloc({
    required this.categoryListUseCase,
    required this.addDefaultCategoriesUseCase,
  }) : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) async {
      emit(CategoryListLoading());
      try {
        await addDefaultCategoriesUseCase(event.userId);
        final categories = await categoryListUseCase(userid: event.userId);
        print("🔥 Kategoriya soni: ${categories.categories.length}");
        emit(CategoryListSuccess(categories));
      } catch (e) {
        emit(CategoryListError("Server error: ${e.toString()}"));
      }
    });


    on<AddDefaultCategoriesEvent>((event, emit) async {
      emit(CategoryListLoading());
      try {
        await addDefaultCategoriesUseCase(event.userId);
        final categories = await categoryListUseCase(userid: event.userId);
        emit(CategoryListSuccess(categories));
      } catch (e) {
        emit(CategoryListError("Error adding default categories: ${e.toString()}"));
      }
    });
  }
}

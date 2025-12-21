import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/categories_list_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';

class CategoryListBloc extends Bloc<CategoriesEvent, CategoryListState> {
  final CategoryListUseCase categoryListUseCase;

  CategoryListBloc({
    required this.categoryListUseCase,
  }) : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) async {
      emit(CategoryListLoading());
      try {
        final categories = await categoryListUseCase(userid: event.userId);
        emit(CategoryListSuccess(categories));
      } catch (e) {
        emit(CategoryListError("Server error: ${e.toString()}"));
      }
    });
  }
}

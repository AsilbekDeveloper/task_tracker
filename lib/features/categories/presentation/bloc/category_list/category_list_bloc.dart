import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/categories_list_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final CategoryListUseCase categoryListUseCase;
  final FirebaseAuth auth;

  CategoryListBloc({
    required this.categoryListUseCase,
    required this.auth,
  }) : super(CategoryListInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(LoadCategories event, Emitter<CategoryListState> emit,) async {
    emit(CategoryListLoading());
    try {
      final user = auth.currentUser;
      if(user == null) {
        emit(const CategoryListError("User not logged"));
        return;
      }

      final categories = await categoryListUseCase(userid: user.uid);

      emit(CategoryListSuccess(categories));
    } catch (e) {
      emit(CategoryListError("Server error: ${e.toString()}"));
    }
  }
}

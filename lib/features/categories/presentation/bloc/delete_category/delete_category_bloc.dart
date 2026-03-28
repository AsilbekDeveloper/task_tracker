import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/delete_category_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class DeleteCategoryBloc extends Bloc<CategoriesEvent, DeleteCategoryState> {
  final DeleteCategoryUseCase deleteCategoryUseCase;
  final FirebaseAuth auth;

  DeleteCategoryBloc({required this.deleteCategoryUseCase, required this.auth})
      : super(DeleteCategoryInitial()) {
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onDeleteCategory(DeleteCategory event, Emitter<DeleteCategoryState> emit) async {
    emit(DeleteCategoryLoading());
    try {
      final user = auth.currentUser;
      if (user == null) {
        emit(DeleteCategoryError(t.auth.userNotLoggedIn));
        return;
      }

      await deleteCategoryUseCase(categoryId: event.categoryId);

      emit(DeleteCategorySuccess(event.categoryId));
    } catch (e) {
      emit(DeleteCategoryError("${t.errors.serverError} ${e.toString()}"));
    }
  }
}

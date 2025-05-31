import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/create_category_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/delete_category_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_state.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_state.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/delete_task_use_case.dart';

class DeleteCategoryBloc extends Bloc<CategoriesEvent, DeleteCategoryState> {
  final DeleteCategoryUseCase deleteCategoryUseCase;

  DeleteCategoryBloc({required this.deleteCategoryUseCase})
      : super(DeleteCategoryInitial()) {
    on<DeleteCategoryEvent>((event, emit) async {
      emit(DeleteCategoryLoading());
      try {
        await deleteCategoryUseCase(categoryId: event.categoryId);

        emit(DeleteCategorySuccess(event.categoryId));
      } catch (e) {
        emit(DeleteCategoryError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}

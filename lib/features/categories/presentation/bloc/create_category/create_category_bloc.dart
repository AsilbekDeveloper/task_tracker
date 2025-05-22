import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/create_category_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_state.dart';

class CreateCategoryBloc extends Bloc<CategoriesEvent, CreateCategoryState> {
  final CreateCategoryUseCase createCategoryUseCase;

  CreateCategoryBloc({required this.createCategoryUseCase})
      : super(CreateCategoryInitial()) {
    on<CreateCategoryEvent>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        final newCategory = await createCategoryUseCase(
          categoryName: event.categoryName,
          userId: event.userId,
          iconCode: event.icon.codePoint,
          fontFamily: event.icon.fontFamily,
          color: event.color.toARGB32(),
        );

        emit(CreateCategorySuccess(newCategory));
      } catch (e) {
        emit(CreateCategoryError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}

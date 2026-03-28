import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/create_category_use_case.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class CreateCategoryBloc
    extends Bloc<CategoriesEvent, CreateCategoryState> {
  final CreateCategoryUseCase createCategoryUseCase;
  final FirebaseAuth auth;

  CreateCategoryBloc({required this.createCategoryUseCase, required this.auth})
    : super(CreateCategoryInitial()) {
    on<CreateCategory>(_onCreateCategory);
  }

  Future<void> _onCreateCategory(CreateCategory event, Emitter<CreateCategoryState> emit) async {
    emit(CreateCategoryLoading());
    try {
      final user = auth.currentUser;
      if(user == null) {
        emit(CreateCategoryError(t.auth.userNotLoggedIn));
        return;
      }

      final newCategory = await createCategoryUseCase(
        categoryName: event.name,
        userId: user.uid,
        iconCode: event.icon.codePoint,
        color: event.color.toARGB32(),
      );

      emit(CreateCategorySuccess(newCategory));
    } catch (e) {
      emit(CreateCategoryError("${t.errors.serverError} ${e.toString()}"));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';

class SignInBloc extends Bloc<AuthEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final AddDefaultCategoriesUseCase addDefaultCategoriesUseCase;

  SignInBloc({required this.signInUseCase, required this.addDefaultCategoriesUseCase}) : super(SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(SignInLoading());
      try {
        final user = await signInUseCase(
          email: event.email,
          password: event.password,
        );
        await addDefaultCategoriesUseCase(user.uid);
        emit(SignInSuccess(user));
      } catch (e) {
        emit(SignInError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/generated/strings.g.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<AuthEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpEvent>(_onSignUp);
  }

  Future<void> _onSignUp(
      SignUpEvent event,
      Emitter<SignUpState> emit,
      ) async {
    if (event.password != event.confirmPassword) {
      emit(SignUpError(t.auth.passwordsDoNotMatch));
      return;
    }

    emit(SignUpLoading());

    try {
      final user = await signUpUseCase(
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess(user));
    } catch (e) {
      emit(SignUpError("${t.errors.serverError} ${e.toString()}"));
    }
  }
}

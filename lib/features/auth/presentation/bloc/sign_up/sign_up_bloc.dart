import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<AuthEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await signUpUseCase(
          email: event.email,
          password: event.password,
        );
        emit(SignUpSuccess(user));
      } catch (e) {
        emit(SignUpError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}

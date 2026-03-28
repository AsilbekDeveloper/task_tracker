import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(SignUpError("Fill email and password"));
      return;
    }

    if (event.password != event.confirmPassword) {
      emit(SignUpError(t.auth.passwordsDoNotMatch));
      return;
    }

    if (event.password.length < 6) {
      emit(SignUpError("Password must be at least 6 characters"));
      return;
    }

    emit(SignUpLoading());

    try {
      final user = await signUpUseCase(
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(_mapFirebaseAuthError(e.code)));
    } catch (e) {
      emit(SignUpError("Registration failed. Please try again."));
    }
  }

  // TODO need to do Localization
  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password sign-up is not enabled.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'Registration failed. Please try again.';
    }
  }
}

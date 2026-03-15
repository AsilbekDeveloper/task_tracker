import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';

class SignInBloc extends Bloc<AuthEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final AddDefaultCategoriesUseCase addDefaultCategoriesUseCase;

  SignInBloc({required this.signInUseCase, required this.addDefaultCategoriesUseCase}) : super(SignInInitial()) {
    on<SignInEvent>(_onSignIn);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<SignInState> emit) async {
    if(event.email.isEmpty || event.password.isEmpty) {
      emit(SignInError("Fill email and password"));
      return;
    }

    emit(SignInLoading());

    try {
      final user = await signInUseCase(email: event.email, password: event.password);

      final box = await Hive.openBox('userBox');
      await box.put('uid', user.uid);

      // Add default categories in background — don't block sign-in on failure
      try {
        await addDefaultCategoriesUseCase(user.uid);
      } catch (_) {
        // Non-critical: default categories can be added later
      }

      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInError(_mapFirebaseAuthError(e.code)));
    } catch (e) {
      emit(SignInError('Sign-in failed. Please try again.'));
    }
  }

  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'Sign-in failed. Please try again.';
    }
  }
}

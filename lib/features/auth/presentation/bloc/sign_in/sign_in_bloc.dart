import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SignInBloc extends Bloc<AuthEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final AddDefaultCategoriesUseCase addDefaultCategoriesUseCase;

  SignInBloc({
    required this.signInUseCase,
    required this.addDefaultCategoriesUseCase,
  }) : super(SignInInitial()) {
    on<SignInEvent>(_onSignIn);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<SignInState> emit) async {
    final t = LocaleSettings.instance.currentTranslations;

    // 1. Email bo'sh
    if (event.email.trim().isEmpty) {
      emit(SignInError(
        t.auth.enterEmail,
        fieldError: SignInFieldError.email,
      ));
      return;
    }

    // 2. Email format noto'g'ri
    if (!_isValidEmail(event.email.trim())) {
      emit(SignInError(
        t.auth.invalidEmail,
        fieldError: SignInFieldError.email,
      ));
      return;
    }

    // 3. Parol bo'sh
    if (event.password.isEmpty) {
      emit(SignInError(
        t.auth.enterPassword,
        fieldError: SignInFieldError.password,
      ));
      return;
    }

    // 4. Parol juda qisqa
    if (event.password.length < 6) {
      emit(SignInError(
        t.auth.passwordTooShort,
        fieldError: SignInFieldError.password,
      ));
      return;
    }

    emit(SignInLoading());

    try {
      final user = await signInUseCase(
        email: event.email.trim(),
        password: event.password,
      );

      await addDefaultCategoriesUseCase(user.uid);

      final box = await Hive.openBox('userBox');
      await box.put('uid', user.uid);

      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignInError(
        _mapFirebaseError(e.code, t),
        fieldError: SignInFieldError.none,
      ));
    } catch (_) {
      emit(SignInError(
        t.errors.unknownError,
        fieldError: SignInFieldError.none,
      ));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  String _mapFirebaseError(String code, Translations t) {
    switch (code) {
      case 'invalid-credential':
      case 'INVALID_LOGIN_CREDENTIALS':
        return t.errors.invalidCredentials;
      case 'user-not-found':
        return t.errors.userNotFound;
      case 'wrong-password':
        return t.errors.wrongPassword;
      case 'invalid-email':
        return t.errors.invalidEmailFormat;
      case 'user-disabled':
        return t.errors.userDisabled;
      case 'too-many-requests':
        return t.errors.tooManyRequests;
      case 'network-request-failed':
        return t.errors.networkError;
      default:
        return t.errors.unknownError;
    }
  }
}
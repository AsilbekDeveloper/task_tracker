import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/google_sign_in_use_case.dart';
import 'package:task_tracker_app/features/categories/domain/use_cases/add_default_categories_use_case.dart';
import 'google_sign_in_event.dart';
import 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  final GoogleSignInUseCase googleSignInUseCase;
  final AddDefaultCategoriesUseCase addDefaultCategoriesUseCase;

  GoogleSignInBloc({
    required this.googleSignInUseCase,
    required this.addDefaultCategoriesUseCase,
  }) : super(GoogleSignInInitial()) {
    on<GoogleSignInPressed>(_onGoogleSignIn);
  }

  Future<void> _onGoogleSignIn(
      GoogleSignInPressed event, Emitter<GoogleSignInState> emit) async {
    emit(GoogleSignInLoading());

    try {
      final user = await googleSignInUseCase();

      if (user == null) {
        emit(const GoogleSignInError("Google Sign-In cancelled by user"));
        return;
      }

      await addDefaultCategoriesUseCase(user.uid);

      final box = await Hive.openBox('userBox');
      await box.put('uid', user.uid);

      emit(GoogleSignInSuccess());
    } catch (e) {
      emit(GoogleSignInError('Google Sign-In failed: ${e.toString()}'));
    }
  }
}

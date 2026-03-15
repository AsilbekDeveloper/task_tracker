import 'package:bloc/bloc.dart';
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

      await addDefaultCategoriesUseCase(user.uid);

      final box = await Hive.openBox('userBox');
      await box.put('uid', user.uid);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError('Server error: ${e.toString()}'));
    }
  }
}

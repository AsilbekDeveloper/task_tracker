import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SignOutBloc extends Bloc<AuthEvent, SignOutState> {
  final SignOutUseCase signOutUseCase;

  SignOutBloc({required this.signOutUseCase}) : super(SignOutInitial()) {
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<SignOutState> emit,
  ) async {
    emit(SignOutLoading());
    try {
      await signOutUseCase();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutError("${t.errors.serverError} ${e.toString()}"));
    }
  }
}

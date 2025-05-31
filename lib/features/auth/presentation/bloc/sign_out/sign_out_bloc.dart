import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:task_tracker_app/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_in/sign_in_state.dart';
import 'package:task_tracker_app/features/auth/presentation/bloc/sign_out/sign_out_state.dart';

class SignOutBloc extends Bloc<AuthEvent, SignOutState> {
  final SignOutUseCase signOutUseCase;

  SignOutBloc({required this.signOutUseCase}) : super(SignOutInitial()) {
    on<SignOutEvent>((event, emit) async {
      emit(SignOutLoading());
      try {
        await signOutUseCase();
        emit(SignOutSuccess());
      } catch (e) {
        emit(SignOutError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<void> call() {
    return authRepository.signOut();
  }
}

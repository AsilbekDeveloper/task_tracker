import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<User> call({required String email, required String password}) {
    return authRepository.signUp(email: email, password: password);
  }
}
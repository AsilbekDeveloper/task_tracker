import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  Future<User> call({required String email, required String password}) {
    return authRepository.signIn(email: email, password: password);
  }
}

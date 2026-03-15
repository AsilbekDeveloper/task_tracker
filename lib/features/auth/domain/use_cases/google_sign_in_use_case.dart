import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<User?> call() {
    return repository.signInWithGoogle();
  }
}
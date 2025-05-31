import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_tracker_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_tracker_app/features/auth/data/data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<User> signIn({required String email, required String password}) {
    return authRemoteDataSource.signIn(email: email, password: password);
  }

  @override
  Future<User> signUp({required String email, required String password}) {
    return authRemoteDataSource.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return authRemoteDataSource.signOut();
  }
}

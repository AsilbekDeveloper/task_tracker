import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn({required String email, required String password});
  Future<User> signUp({required String email, required String password});
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);
  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'sign-in-failed',
        message: e.toString(),
      );
    }
  }

  @override
  Future<User> signUp({required String email, required String password}) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user!;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'sign-in-failed',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirebaseAuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   Future<User> signUp({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user!;
//     } on FirebaseAuthException catch (e) {
//       throw Exception('Sign up failed: ${e.message}');
//     }
//   }
//
//   Future<User> signIn({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user!;
//     } on FirebaseAuthException catch (e) {
//       throw Exception('Sign in failed: ${e.message}');
//     }
//   }
//
//   Future<void> signOut() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       throw Exception('Sign out failed: $e');
//     }
//   }
//
//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }
// }

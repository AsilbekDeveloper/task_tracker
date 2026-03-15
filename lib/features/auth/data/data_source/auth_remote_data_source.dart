import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn({required String email, required String password});
  Future<User> signUp({required String email, required String password});
  Future<void> signOut();
  Future<User?> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.googleSignIn);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'sign-up-failed',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } catch (e) {
      debugPrint("Sign out xatosi: $e");
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      // 👇 Step 1: show Google Sign-In dialog
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null; // user cancelled

      // 👇 Step 2: get auth data from Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 👇 Step 3: build credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 👇 Step 4: sign in with Firebase
      final userCredential = await firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException {
      rethrow; // Firebase xatolarni class bilan tutadi
    } catch (e) {
      throw FirebaseAuthException(
        code: "google-sign-in-failed",
        message: e.toString(),
      );
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final User? user;

  SignInSuccess(this.user);
}

class SignInError extends SignInState {
  final String message;

  SignInError(this.message);
}
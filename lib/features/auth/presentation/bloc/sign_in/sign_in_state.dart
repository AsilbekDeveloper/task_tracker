import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInError extends SignInState {
  final String message;
  final SignInFieldError? fieldError;

  const SignInError(this.message, {this.fieldError});

  @override
  List<Object?> get props => [message];
}

enum SignInFieldError { email, password, none }
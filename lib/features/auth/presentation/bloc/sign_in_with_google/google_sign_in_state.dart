import 'package:equatable/equatable.dart';

abstract class GoogleSignInState extends Equatable {
  const GoogleSignInState();

  @override
  List<Object?> get props => [];
}

// Default holat
class GoogleSignInInitial extends GoogleSignInState {}

// Loading holatida
class GoogleSignInLoading extends GoogleSignInState {}

// Success
class GoogleSignInSuccess extends GoogleSignInState {}

// Error
class GoogleSignInError extends GoogleSignInState {
  final String message;

  const GoogleSignInError(this.message);

  @override
  List<Object?> get props => [message];
}

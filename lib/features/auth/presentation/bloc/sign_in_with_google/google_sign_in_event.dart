import 'package:equatable/equatable.dart';

abstract class GoogleSignInEvent extends Equatable {
  const GoogleSignInEvent();

  @override
  List<Object?> get props => [];
}

// User Google button bosdi
class GoogleSignInPressed extends GoogleSignInEvent {}

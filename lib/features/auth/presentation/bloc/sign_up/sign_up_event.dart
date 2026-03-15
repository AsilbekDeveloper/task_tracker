import 'package:task_tracker_app/features/auth/presentation/bloc/auth_event.dart';

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [email, password, confirmPassword];
}

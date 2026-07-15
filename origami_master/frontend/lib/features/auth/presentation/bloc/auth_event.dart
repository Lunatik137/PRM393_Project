import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class GoogleLoginRequested extends AuthEvent {
  final String idToken;

  const GoogleLoginRequested(this.idToken);

  @override
  List<Object> get props => [idToken];
}

class RegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  const RegisterRequested(this.username, this.email, this.password, this.confirmPassword);
  @override
  List<Object?> get props => [username, email, password, confirmPassword];
}

class LogoutRequested extends AuthEvent {}

class CheckSessionRequested extends AuthEvent {}

class RefreshTokenRequested extends AuthEvent {}

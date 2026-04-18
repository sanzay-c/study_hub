part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class UsernameChanged extends AuthEvent {
  final String username;
  const UsernameChanged(this.username);
  
  @override
  List<Object?> get props => [username];
}

class FullnameChanged extends AuthEvent {
  final String fullname;
  const FullnameChanged(this.fullname);
  
  @override
  List<Object?> get props => [fullname];
}

class EmailChanged extends AuthEvent {
  final String email;
  const EmailChanged(this.email);
  
  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final String password;
  const PasswordChanged(this.password);
  
  @override
  List<Object?> get props => [password];
}

// ← Changed: No parameters needed anymore!
class SignUpSubmitted extends AuthEvent {
  const SignUpSubmitted();  // ← Empty constructor
  
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted();  
  
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();

  @override
  List<Object?> get props => [];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();

  @override
  List<Object?> get props => [];
}

class DeleteAccountRequested extends AuthEvent {
  final String password;
  const DeleteAccountRequested(this.password);

  @override
  List<Object?> get props => [password];
}
part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String username;      // ← Store username in state
  final String fullname;      // ← Store fullname in state
  final String email;         // ← Store email in state
  final String password;      // ← Store password in state
  final String? usernameError;
  final String? fullnameError;
  final String? emailError;
  final String? passwordError;
  final String? submitError;
   final User? user;

  const AuthState({
    this.status = AuthStatus.initial,
    this.username = '',        // ← Default empty
    this.fullname = '',        // ← Default empty
    this.email = '',           // ← Default empty
    this.password = '',        // ← Default empty
    this.usernameError,
    this.fullnameError,
    this.emailError,
    this.passwordError,
    this.submitError,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? username,          // ← Add to copyWith
    String? fullname,          // ← Add to copyWith
    String? email,             // ← Add to copyWith
    String? password,          // ← Add to copyWith
    String? usernameError,
    String? fullnameError,
    String? emailError,
    String? passwordError,
    String? submitError,
     Object? user
  }) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      usernameError: usernameError,
      fullnameError: fullnameError,
      emailError: emailError,
      passwordError: passwordError,
      submitError: submitError,
      user: user == null ? this.user : user as User?
    );
  }

  @override
  List<Object?> get props => [
        status,
        username,          
        fullname,          
        email,             
        password,          
        usernameError,
        fullnameError,
        emailError,
        passwordError,
        submitError,
        user,
      ];
}
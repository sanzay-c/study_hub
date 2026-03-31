import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:study_hub/features/auth/domain/entities/user.dart'; 
import 'package:study_hub/features/auth/domain/usecase/login_usecasse.dart';
import 'package:study_hub/features/auth/domain/usecase/logout_usecase.dart';
import 'package:study_hub/features/auth/domain/usecase/signup_usecase.dart';

import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:study_hub/core/notification/notification_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase signupUsecase;
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;
  final AuthRepo authRepo;

  AuthBloc(this.signupUsecase, this.loginUsecase, this.authRepo, this.logoutUsecase)
    : super(const AuthState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<FullnameChanged>(_onFullnameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isAuthenticated = await authRepo.isAuthenticated();
    if (isAuthenticated) {
      final user = await authRepo.getCurrentUser();
      emit(state.copyWith(status: AuthStatus.success, user: user));
      
      // Sync FCM token on app start if already logged in
      _updateDeviceToken();
    }
  }

  // Store username in state and clear error
  void _onUsernameChanged(UsernameChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        username: event.username,
        usernameError: null, 
      ),
    );
  }

  void _onFullnameChanged(FullnameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(fullname: event.fullname, fullnameError: null));
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, emailError: null));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, passwordError: null));
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    // Validate 
    final usernameError = state.username.trim().isEmpty
        ? 'Username required'
        : null;
    final fullnameError = state.fullname.trim().isEmpty
        ? 'Full name required'
        : null;
    final emailError =
        RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(state.email.trim())
        ? null
        : 'Invalid email';
    final passwordError = state.password.length < 6 ? 'Min 6 characters' : null;

    final hasError = [
      usernameError,
      fullnameError,
      emailError,
      passwordError,
    ].any((e) => e != null);

    if (hasError) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          usernameError: usernameError,
          fullnameError: fullnameError,
          emailError: emailError,
          passwordError: passwordError,
          submitError: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        usernameError: null,
        fullnameError: null,
        emailError: null,
        passwordError: null,
        submitError: null,
      ),
    );

    try {
      await signupUsecase(
        username: state.username.trim(),
        fullname: state.fullname.trim(),
        email: state.email.trim(),
        password: state.password,
      );
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          submitError: errorMessage.isNotEmpty ? errorMessage : 'Signup failed',
        ),
      );
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final usernameError =
        state.username.trim().isEmpty ? 'Username required' : null;
    final passwordError = state.password.isEmpty ? 'Password required' : null;

    if (usernameError != null || passwordError != null) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          usernameError: usernameError, 
          passwordError: passwordError,
          submitError: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AuthStatus.loading,
        usernameError: null,
        passwordError: null,
        submitError: null,
      ),
    );

    try {
      final authResponse = await loginUsecase(
        username: state.username.trim(),
        password: state.password,
      );
      
      emit(state.copyWith(
        status: AuthStatus.success,
        user: authResponse.user,
      ));

      // Sync FCM token on successful login
      _updateDeviceToken();
    } catch (e) {
      log("LOGIN ERROR: $e");
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          submitError: errorMessage.isNotEmpty ? errorMessage : 'Login Failed',
        ),
      );
    }
  }

  FutureOr<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      await logoutUsecase();
      emit(const AuthState());
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(state.copyWith(
        status: AuthStatus.error,
        submitError: errorMessage.isNotEmpty ? errorMessage : 'Logout failed',
      ));
    }
  }

  /// Silently update the FCM token on the backend
  Future<void> _updateDeviceToken() async {
    try {
      final token = await PushNotificationService.getToken();
      if (token != null) {
        await authRepo.updateFcmToken(token);
      }
    } catch (e) {
      log("🔴 BLOC: Failed to sync FCM token: $e");
    }
  }
}

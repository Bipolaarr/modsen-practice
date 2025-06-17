import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, error }

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid; // Added password validation state
  final AuthStatus status;
  final String? errorMessage;
  final bool showError;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isEmailValid = true,
    this.isPasswordValid = true, // Default to valid
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.showError = false,
  });

  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid, // Add to copyWith
    AuthStatus? status,
    String? errorMessage,
    bool? showError,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        status,
        errorMessage,
        showError,
      ];

  factory AuthState.initial() => const AuthState();
}
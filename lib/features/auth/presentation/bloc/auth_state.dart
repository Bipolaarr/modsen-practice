import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, error }

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool isActive;
  final bool isEmailValid;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState({
    this.email = '',
    this.password = '',
    this.isActive = false,
    this.isEmailValid = true,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    String? email,
    String? password,
    bool? isActive,
    bool? isEmailValid,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isActive,
        isEmailValid,
        status,
        errorMessage,
      ];

  factory AuthState.initial() => const AuthState();
}
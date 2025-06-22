import 'package:bloc/bloc.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';
import 'package:practice_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BiometricsRepository _auth = serviceLocator<BiometricsRepository>();
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;

  AuthCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
  }) : super(AuthState.initial());

  void updateEmail(String email) {
    emit(state.copyWith(
      email: email,
      isEmailValid: _isEmailValid(email),
      showError: false,
    ));
  }

  void updatePassword(String password) {
    emit(state.copyWith(
      password: password,
      isPasswordValid: _isPasswordValid(password),
      showError: false,
    ));
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'[\w\-\.]+@([\w\-]+\.)+[\w\-]+');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  Future<void> signIn() async {
    if (state.isLoading) return;
    
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
      showError: true,
    ));

    try {
      final result = await signInUsecase.call(
        params: UserModel(
          email: state.email.trim(),
          password: state.password,
        ),
      );

      result.fold(
        (error) => emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: error.toString(),
        )),
        (_) async { 
          // Save user for Face ID in background without blocking
          _saveUserForBiometrics();
          emit(state.copyWith(status: AuthStatus.authenticated)); 
        }
      );
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error, 
        errorMessage: "Unexpected error occurred"
      ));
    }
  }

  Future<void> _saveUserForBiometrics() async {
    try {
      final user = UserModel(
        email: state.email.trim(),
        password: state.password
      );
      await _auth.saveUser(user);
    } catch (e) {
      // Silently fail - don't show error to user
      print("Biometric save error: $e");
    }
  }

  Future<void> signUp() async {
    if (state.isLoading) return;
    
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
      showError: true,
    ));

    try {
      final result = await signUpUsecase.call(
        params: UserModel(
          email: state.email.trim(),
          password: state.password,
        ),
      );

      result.fold(
        (error) => emit(state.copyWith(
          status: AuthStatus.error,
          errorMessage: error.toString(),
        )),
        (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error, 
        errorMessage: "Unexpected error occurred"
      ));
    }
  }
}
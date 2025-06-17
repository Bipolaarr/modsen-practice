import 'package:bloc/bloc.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
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
      showError: false, // Reset error display on email change
    ));
  }

  void updatePassword(String password) {
    emit(state.copyWith(
      password: password,
      showError: false, // Reset error display on password change
    ));
  }

  void validateEmail() {
    emit(state.copyWith(isEmailValid: _isEmailValid(state.email)));
  }

  void setActive(bool isActive) {
    emit(state.copyWith(
      isActive: isActive,
      isEmailValid: _isEmailValid(state.email),
    ));
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'[\w\-\.]+@([\w\-]+\.)+[\w\-]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> signIn() async {
    if (state.isLoading) return;
    
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
      showError: true, // Set to show error only after attempt
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
        (_) => emit(state.copyWith(status: AuthStatus.authenticated)),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error, 
        errorMessage: "Unexpected error occurred"
      ));
    }
  }

  Future<void> signUp() async {
    if (state.isLoading) return;
    
    emit(state.copyWith(
      status: AuthStatus.loading,
      errorMessage: null,
      showError: true, // Set to show error only after attempt
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
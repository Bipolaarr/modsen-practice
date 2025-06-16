import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  SignUpCubit() : super(SignUpState.initial());

  void updateEmail(String email) {

      emit(state.copyWith(email: email, isActive: true));

  }

  void updatePassword(String password) {

    emit(state.copyWith(password: password));

  }

  void validateEmail() {
    final isValid = isEmailValid(state.email);
    emit(state.copyWith(isVaild: isValid));
  }

  void setActive(bool isActive) {
    final isValid = isEmailValid(state.email);
    emit(state.copyWith(isVaild: isValid));

  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'[\w\-\.]+@([\w\-]+\.)+[\w\-]+');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.isEmpty; 
  } 
 
}
class SignUpState {

  final String email; 
  final String password; 
  final bool isValid; 
  final bool isActive;

  SignUpState ({required this.email, required this.password, required this.isActive, required this.isValid});

  factory SignUpState.initial() => SignUpState(email: '', password: '', isActive: false, isValid: true);

  SignUpState copyWith({
    String? email,
    String? password,
    bool ? isActive,
    bool ? isVaild
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive, 
      isValid: isVaild ?? this.isValid

    );
  }

}
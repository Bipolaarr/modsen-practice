class SplashState {
  final double logoOpacity;
  final double contentOpacity;
  final bool quickAuthChecked; 
  final String? biometricError;    

  const SplashState({
    required this.logoOpacity,
    required this.contentOpacity,
    this.quickAuthChecked = false,
    this.biometricError,
  });

  factory SplashState.initial() {
    return const SplashState(
      logoOpacity: 1,
      contentOpacity: 0,
      quickAuthChecked: false,
    );
  }

  SplashState copyWith({
    double? logoOpacity,
    double? contentOpacity,
    bool? shouldNavigateToHome,
    String? biometricError,
  }) {
    return SplashState(
      logoOpacity: logoOpacity ?? this.logoOpacity,
      contentOpacity: contentOpacity ?? this.contentOpacity,
      quickAuthChecked: shouldNavigateToHome ?? this.quickAuthChecked,
      biometricError: biometricError ?? this.biometricError,
    );
  }
}
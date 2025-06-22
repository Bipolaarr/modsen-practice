class SplashState {
  final double logoOpacity;
  final double contentOpacity;
  final bool quickAuthChecked;
  final bool shouldNavigateToHome;
  final String? biometricError;

  const SplashState({
    required this.logoOpacity,
    required this.contentOpacity,
    this.quickAuthChecked = false,
    this.shouldNavigateToHome = false,
    this.biometricError,
  });

  factory SplashState.initial() {
    return const SplashState(
      logoOpacity: 1,
      contentOpacity: 0,
      quickAuthChecked: false,
      shouldNavigateToHome: false,
    );
  }

  SplashState copyWith({
    double? logoOpacity,
    double? contentOpacity,
    bool? quickAuthChecked,
    bool? shouldNavigateToHome,
    String? biometricError,
  }) {
    return SplashState(
      logoOpacity: logoOpacity ?? this.logoOpacity,
      contentOpacity: contentOpacity ?? this.contentOpacity,
      quickAuthChecked: quickAuthChecked ?? this.quickAuthChecked,
      shouldNavigateToHome: shouldNavigateToHome ?? this.shouldNavigateToHome,
      biometricError: biometricError ?? this.biometricError,
    );
  }
}
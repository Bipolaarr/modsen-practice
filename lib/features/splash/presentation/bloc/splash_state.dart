class SplashState {

  final double logoOpacity;
  final double contentOpacity;

  const SplashState({
    required this.logoOpacity,
    required this.contentOpacity,
  });

  factory SplashState.initial() {
    return const SplashState(logoOpacity: 1, contentOpacity: 0);
  }

  SplashState copyWith({
    double? logoOpacity,
    double? contentOpacity,
  }) {

    return SplashState(
      logoOpacity: logoOpacity ?? this.logoOpacity,
      contentOpacity: contentOpacity ?? this.contentOpacity,
    );

  }
  
}
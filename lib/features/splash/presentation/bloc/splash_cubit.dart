import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/features/auth/domain/usecases/quick_auth_check_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/quick_auth_usecase.dart';
import 'package:practice_app/features/splash/presentation/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final QuickAuthCheckUsecase _quickAuthCheckUsecase;
  final QuickAuthUsecase _quickAuthUsecase;

  SplashCubit(this._quickAuthCheckUsecase, this._quickAuthUsecase) 
      : super(SplashState.initial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await _checkBiometricLogin();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(contentOpacity: 1));
  }

  Future<void> _checkBiometricLogin() async {
    try {
      final result = await _quickAuthCheckUsecase();
      
      await result.fold(
        (failure) async {
          // Start animation only after failure
          await _startAnimation();
          emit(state.copyWith(
            biometricError: failure.toString(),
            quickAuthChecked: true,
          ));
        },
        (shouldAttempt) async {
          if (!shouldAttempt) {
            // Start animation when no Face ID attempt needed
            await _startAnimation();
            emit(state.copyWith(quickAuthChecked: true));
            return;
          }

          final authResult = await _quickAuthUsecase();
          authResult.fold(
            (error) async {
              // Start animation only after Face ID error
              await _startAnimation();
              emit(state.copyWith(
                biometricError: error.toString(),
                quickAuthChecked: true,
              ));
            },
            (success) {
              if (success) {
                // Success: navigate immediately without animation
                emit(state.copyWith(shouldNavigateToHome: true));
              } else {
                // User canceled: start animation
                _startAnimation().then((_) {
                  emit(state.copyWith(quickAuthChecked: true));
                });
              }
            }
          );
        }
      );
    } catch (e) {
      // Start animation only after exception
      await _startAnimation();
      emit(state.copyWith(
        biometricError: e.toString(),
        quickAuthChecked: true,
      ));
    }
  }
}
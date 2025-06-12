import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/features/splash/presentation/bloc/splash_state.dart';

class SplashCubit extends Cubit<SplashState>{

  SplashCubit() : super(SplashState.initial()) {

    _startAnimation();

  }

  Future<void> _startAnimation() async {

    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(contentOpacity: 1));

  }

}
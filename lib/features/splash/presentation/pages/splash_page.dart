import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:practice_app/features/splash/presentation/widgets/splash_content.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: const SplashContent(),
    );
  }

}



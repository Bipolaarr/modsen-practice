
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:practice_app/features/auth/presentation/widgets/auth_content.dart';

@RoutePage()
class SignInPage extends StatelessWidget {

  const SignInPage({super.key});

 @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: AuthContent(leadingButtonText: "Sign Up", mainLabelText: "Sign in to \nyour account", leadingRoute: SignUpRoute(), authButtonText: "Sign In", authButtonRoute: HomeRoute(), showTerms: false),
    );

  }

}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:practice_app/features/auth/presentation/widgets/auth_content.dart';

@RoutePage()
class SignUpPage extends StatelessWidget{

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: AuthContent(leadingButtonText: "Sign In", mainLabelText: "Let's create \nyour account", leadingRoute: SignInRoute(), authButtonText: "Sign Up", authButtonRoute: SignInRoute(), showTerms: true,),
    );

  }


}

/// dont travelling a lot of times 
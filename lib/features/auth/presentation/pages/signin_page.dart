
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/auth/presentation/widgets/auth_content.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContent(
      leadingButtonText: "Sign Up",
      mainLabelText: "Sign in to \nyour account",
      leadingRoute: const SignUpRoute(),
      authButtonText: "Sign In",
      authButtonRoute: const HomeRoute(),
      showTerms: false,
    );
  }
}
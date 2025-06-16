
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/auth/presentation/widgets/auth_content.dart';

// signup_page.dart
@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContent(
      leadingButtonText: "Sign In",
      mainLabelText: "Let's create \nyour account",
      leadingRoute: const SignInRoute(),
      authButtonText: "Sign Up",
      authButtonRoute: const SignInRoute(),
      showTerms: true,
    );
  }
}

/// dont travelling a lot of times 
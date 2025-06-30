import 'package:auto_route/auto_route.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:practice_app/features/auth/presentation/bloc/auth_state.dart';

class AuthContent extends StatelessWidget {
  final String leadingButtonText;
  final String mainLabelText; 
  final String authButtonText; 
  final PageRouteInfo leadingRoute; 
  final PageRouteInfo authButtonRoute; 
  final bool showTerms; 

  const AuthContent({super.key, 
    required this.leadingButtonText, 
    required this.leadingRoute, 
    required this.mainLabelText,
    required this.authButtonText,
    required this.authButtonRoute,
    required this.showTerms
  });
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        signInUsecase: serviceLocator<SignInUsecase>(),
        signUpUsecase: serviceLocator<SignUpUsecase>(),
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isAuthenticated) {
            context.router.replace(authButtonRoute);
          }
          
          if (state.status == AuthStatus.error && state.showError) {
            FlashyFlushbar(
              duration: const Duration(seconds: 5),
              isDismissible: true,
              dismissDirection: DismissDirection.up,
              backgroundColor: Constants.formBlueColor,
              borderRadius: BorderRadiusGeometry.circular(20),
              message: state.errorMessage!,
              messageStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: -0.5,
                fontWeight: FontWeight.bold                
              ),
            ).show();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            leadingWidth: 100,
            backgroundColor: Colors.black,
            leading: Container(
              constraints: const BoxConstraints(minWidth: 80),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () => context.router.replace(leadingRoute),
                child: Text(
                  leadingButtonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            title: SvgPicture.asset(Constants.logo, width: 23, height: 21),
            actions: [
              IconButton(
                onPressed: () => context.router.pop(),
                icon: const Icon(CupertinoIcons.clear),
                color: Colors.white,
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                mainLabelText, 
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  letterSpacing: -2,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final cubit = context.read<AuthCubit>();
                              return TextField(
                                onChanged: cubit.updateEmail,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: -0.5
                                ),
                                cursorColor: Constants.formBlueColor,
                                decoration: InputDecoration(
                                  labelText: "Enter your email address",
                                  labelStyle: const TextStyle(
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                    color: Colors.grey
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  errorStyle: const TextStyle(color: Colors.red),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: !state.isEmailValid 
                                          ? Colors.red 
                                          : Colors.grey,
                                    )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: state.isEmailValid 
                                          ? Colors.white 
                                          : Colors.red,
                                    )
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final cubit = context.read<AuthCubit>();
                              return TextField(
                                onChanged: cubit.updatePassword,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: -0.5
                                ),
                                cursorColor: Constants.formBlueColor,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Enter your password",
                                  labelStyle: const TextStyle(
                                    fontSize: 16,
                                    letterSpacing: -0.5,
                                    color: Colors.grey
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: !state.isPasswordValid 
                                          ? Colors.red 
                                          : Colors.grey,
                                    )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: state.isPasswordValid 
                                          ? Colors.white 
                                          : Colors.red,
                                    )
                                  ),
                                  errorText: state.showError && !state.isPasswordValid
                                      ? ''
                                      : null,
                                ),
                              );
                            }
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                if (showTerms) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "By signing up you accept the Terms of Service & Privacy Policy.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        letterSpacing: -0.5
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 25,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final cubit = context.read<AuthCubit>();
                        
                        return ElevatedButton(
                          onPressed: () {
                            if (showTerms) {
                              cubit.signUp();
                            } else {
                              cubit.signIn();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Constants.formBlueColor
                            ),
                            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            overlayColor: WidgetStateProperty.all<Color>(
                              Constants.formBlueColor.withOpacity(1)),
                            elevation: WidgetStateProperty.all<double>(0),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  authButtonText,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1
                                  )
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
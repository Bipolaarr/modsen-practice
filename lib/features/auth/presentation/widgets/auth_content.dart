import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
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

    final cubit = context.read<SignUpCubit>();
    final  emailController = TextEditingController();
    final  passwordController = TextEditingController();

    return Scaffold(
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
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return FocusScope(
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          if (!hasFocus) {
                            cubit.validateEmail();
                          } else {
                            cubit.setActive(true);
                          }
                        },
                        child: TextField(
                          controller: emailController,
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
                                color:  !state.isValid 
                                    ? Colors.red 
                                    : Colors.grey,
                              )
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: state.isActive && state.isValid 
                                    ? Colors.white 
                                    : Colors.red,
                              )
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return TextField(
                      controller: passwordController,
                      onChanged: (value) => context.read<SignUpCubit>().updatePassword(value),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: -0.5
                      ),
                      cursorColor: Constants.formBlueColor,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Enter your password",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          letterSpacing: -0.5,
                          color: Colors.grey
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                    );
                  }
                ),
              ),
              const Spacer(),
              if (showTerms) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "By signing up you accept the Terms of Service & Privacy Policy.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        letterSpacing: -0.5
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10),
              SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () async {

                          final emailTextData = emailController.text.trim();
                          final passwordTextData = passwordController.text;

                          if (showTerms) {

                            var authResult = await serviceLocator<SignUpUsecase>().call(
                            params: UserModel(
                              email: emailTextData,
                              password: passwordTextData
                            )
                          );

                          authResult.fold((l) {}, (data) {context.router.replace(SignInRoute());});

                          } else {

                            var authResult = await serviceLocator<SignInUsecase>().call(
                            params: UserModel(
                              email: emailTextData,
                              password: passwordTextData
                            )
                          );

                          authResult.fold((l) {}, (data) {context.router.replace(HomeRoute());});

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                          ),
                          backgroundColor: Constants.formBlueColor
                        ),
                        child: Text(
                          authButtonText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
      )
    );
  }
}
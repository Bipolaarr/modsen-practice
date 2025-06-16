import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:practice_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:practice_app/features/splash/presentation/widgets/splash_button.dart';

class SplashContent extends StatelessWidget {

  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {

        return Material(
          color: Colors.black,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedPadding(
                        padding: EdgeInsets.only(
                          top: state.contentOpacity > 0 ? 175 : 100,
                        ),
                        duration: const Duration(milliseconds: 1000),
                        child: AnimatedOpacity(
                          opacity: state.contentOpacity,
                          duration: const Duration(milliseconds: 1500),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Welcome to Coinapp', 
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: Colors.white,
                                    letterSpacing: -2
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'All your crypto transactions in one place! Track coins, add portfolios, buy & sell.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.white,
                                    letterSpacing: -0.5
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 40),
                              SplashButton(
                                backgroundColor: Constants.formBlueColor,
                                label: 'Sign In',
                                onPressed: () => context.router.push(const SignInRoute())
                              ),
                              const SizedBox(height: 20),
                              SplashButton(
                                backgroundColor: Colors.black,
                                label: 'Sign Up',
                                onPressed: () => context.router.push(const SignUpRoute())
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 1000),
                        padding: EdgeInsets.only(
                          bottom: state.contentOpacity > 0 ? 300 : 0,
                        ),
                        child: Opacity(
                          opacity: state.logoOpacity,
                          child: SvgPicture.asset(
                            Constants.logo,
                            width: 120,
                            height: 120,
                            placeholderBuilder: (ctx) => const Icon(CupertinoIcons.exclamationmark_circle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      },
    );

  }

}
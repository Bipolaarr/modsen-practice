import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/features/auth/presentation/pages/signin_page.dart';
import 'package:practice_app/features/auth/presentation/pages/signup_page.dart';
import 'package:practice_app/features/coin/presentation/pages/coin_page.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/presentation/pages/home_page.dart';
import 'package:practice_app/features/splash/presentation/pages/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: CoinRoute.page)

  ];

}

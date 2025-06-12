import 'package:auto_route/auto_route.dart';
import 'package:practice_app/features/auth/presentation/pages/signin_page.dart';
import 'package:practice_app/features/auth/presentation/pages/signup_page.dart';
import 'package:practice_app/features/splash/presentation/pages/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: SigninRoute.page),
    AutoRoute(page: SignupRoute.page),

  ];

}

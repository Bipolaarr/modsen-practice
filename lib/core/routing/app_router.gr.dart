// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter();

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    CoinRoute.name: (routeData) {
      final args = routeData.argsAs<CoinRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoinPage(
          key: args.key,
          coinId: args.coinId,
          initialCoin: args.initialCoin,
        ),
      );
    },
    FavouriteCoinsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavouriteCoinsPage(),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoinPage]
class CoinRoute extends PageRouteInfo<CoinRouteArgs> {
  CoinRoute({
    Key? key,
    required String coinId,
    required CoinModel initialCoin,
    List<PageRouteInfo>? children,
  }) : super(
          CoinRoute.name,
          args: CoinRouteArgs(
            key: key,
            coinId: coinId,
            initialCoin: initialCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'CoinRoute';

  static const PageInfo<CoinRouteArgs> page = PageInfo<CoinRouteArgs>(name);
}

class CoinRouteArgs {
  const CoinRouteArgs({
    this.key,
    required this.coinId,
    required this.initialCoin,
  });

  final Key? key;

  final String coinId;

  final CoinModel initialCoin;

  @override
  String toString() {
    return 'CoinRouteArgs{key: $key, coinId: $coinId, initialCoin: $initialCoin}';
  }
}

/// generated route for
/// [FavouriteCoinsPage]
class FavouriteCoinsRoute extends PageRouteInfo<void> {
  const FavouriteCoinsRoute({List<PageRouteInfo>? children})
      : super(
          FavouriteCoinsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouriteCoinsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

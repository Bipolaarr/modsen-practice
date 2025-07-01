import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:practice_app/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:practice_app/features/favourites/presentation/bloc/favourite_coins_cubit.dart';
import 'package:practice_app/features/favourites/presentation/bloc/favourite_coins_state.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';
import 'package:practice_app/features/home/presentation/widgets/coin_tile.dart';

@RoutePage()
class FavouriteCoinsPage extends StatelessWidget {
  const FavouriteCoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteCoinsCubit(
        favRepo: serviceLocator<FavouritesRepository>(),
        coinsRepo: serviceLocator<CoinsRepository>(),
      )..loadFavorites(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.black,
          title: const Text(
            'My Watchlist',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () => context.router.replace(HomeRoute()),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.person_crop_circle_fill_badge_xmark,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                serviceLocator<LogoutUsecase>().call();
                context.router.replace(const SignInRoute());
              },
            )
          ],
        ),
        body: BlocBuilder<FavouriteCoinsCubit, FavouriteCoinsState>(
          builder: (context, state) {
            if (state is FavouriteCoinsInitial) {
              return _buildInitialPlaceholder();
            }
            
            if (state is FavouriteCoinsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Constants.formBlueColor),
              );
            }
            
            if (state is FavouriteCoinsError) {
              return _buildErrorPlaceholder(context, state.message);
            }
            
            if (state is FavouriteCoinsLoaded) {
              if (state.coins.isEmpty) {
                return _buildEmptyFavoritesPlaceholder();
              }
              
              return RefreshIndicator(
                onRefresh: () async => context.read<FavouriteCoinsCubit>().refreshFavorites(),
                color: Constants.formBlueColor,
                child: _buildCoinList(coins: state.coins),
              );
            }
            
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildCoinList({required List<CoinModel> coins}) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) => CoinTile(coin: coins[index]),
    );
  }

  Widget _buildInitialPlaceholder() {
    return const Center(
      child: Text(
        'Loading favorite coins...',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildEmptyFavoritesPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.star,
            color: Constants.formBlueColor,
            size: 70,
          ),
          const SizedBox(height: 20),
          const Text(
            'No favourites coins added',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -1
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPlaceholder(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: Constants.formBlueColor,
              size: 70,
            ),
            const SizedBox(height: 10),
            const Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -1
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 187,
              child: ElevatedButton(
                onPressed: () {
                  context.read<FavouriteCoinsCubit>().loadFavorites();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.formBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
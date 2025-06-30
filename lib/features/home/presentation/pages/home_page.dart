// features/home/presentation/screens/home_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_cubit.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_state.dart';
import 'package:practice_app/features/home/presentation/widgets/coin_tile.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  final double _scrollThreshold = 200.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(serviceLocator<CoinsRepository>())..loadInitialCoins(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.black,
          title: const Text(
            'Coins Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.chart_bar_alt_fill,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              // NOT IMPLEMENTED YET
            },
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
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial) {
              return _buildInitialPlaceholder();
            }
            
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Constants.formBlueColor),
              );
            }
            
            if (state is HomeError) {
              return _buildErrorPlaceholder(context, state.message);
            }
            
            List<CoinModel> coins = [];
            bool isLoadingMore = false;
            bool hasReachedMax = false;
            
            if (state is HomeLoadingMore) {
              coins = state.coins;
              isLoadingMore = true;
            }
            else if (state is HomeLoaded) {
              coins = state.coins;
              hasReachedMax = state.hasReachedMax;
            }
            
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  final metrics = notification.metrics;
                  if (metrics.maxScrollExtent - metrics.pixels <= _scrollThreshold) {
                    context.read<HomeCubit>().loadMoreCoins();
                  }
                }
                return false;
              },
              child: _buildCoinList(
                coins: coins,
                isLoadingMore: isLoadingMore,
                hasReachedMax: hasReachedMax
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCoinList({
    required List<CoinModel> coins,
    bool isLoadingMore = false,
    bool hasReachedMax = false
  }) {
    return ListView.builder(
      itemCount: coins.length + (isLoadingMore || !hasReachedMax ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < coins.length) {
          return CoinTile(coin: coins[index]);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: isLoadingMore 
                ? const CircularProgressIndicator(color: Constants.formBlueColor)
                : IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      context.read<HomeCubit>().loadMoreCoins();
                    },
                  ),
            ),
          );
        }
      },
    );
  }

  Widget _buildInitialPlaceholder() {
    return const Center(
      child: Text(
        'Loading cryptocurrency data...',
        style: TextStyle(color: Colors.white70),
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
              color: Colors.red,
              size: 70,
            ),
            const SizedBox(height: 10),
            const Text(
              'Network error occured',
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
                  context.read<HomeCubit>().loadInitialCoins();
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
                    fontSize: 16,
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
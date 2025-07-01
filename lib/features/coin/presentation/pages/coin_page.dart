// features/home/presentation/screens/coin_dashboard/coin_dashboard.dart
import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/coin/presentation/bloc/chart_cubit.dart';
import 'package:practice_app/features/coin/presentation/bloc/chart_state.dart';
import 'package:practice_app/features/coin/presentation/bloc/coin_data_cubit.dart';
import 'package:practice_app/features/coin/presentation/bloc/coin_data_state.dart';
import 'package:practice_app/features/coin/presentation/bloc/favourite_state.dart';
import 'package:practice_app/features/coin/presentation/bloc/favourites_cubit.dart';
import 'package:practice_app/features/coin/presentation/widgets/coin_chart.dart';
import 'package:practice_app/features/coin/presentation/widgets/coin_header.dart';
import 'package:practice_app/features/coin/presentation/widgets/coin_portfolio.dart';
import 'package:practice_app/features/coin/presentation/widgets/coin_stats.dart';
import 'package:practice_app/features/coin/presentation/widgets/coin_timeframe_selector.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';

@RoutePage()
class CoinPage extends StatelessWidget {
  final String coinId;
  final CoinModel initialCoin;

  const CoinPage({
    super.key,
    required this.coinId,
    required this.initialCoin,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<CoinDataCubit>()..fetchCoinData(coinId),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ChartCubit>()..loadChart(coinId, '1M'),
        ),
        BlocProvider(
          create: (context) => serviceLocator<FavouriteCubit>(param1: coinId),
        ),
      ],
      child: _CoinDashboardView(initialCoin: initialCoin),
    );
  }
}

class _CoinDashboardView extends StatelessWidget {
  final CoinModel initialCoin;

  const _CoinDashboardView({required this.initialCoin});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDataCubit, CoinDataState>(
      builder: (context, coinState) {
        final coin = coinState is CoinDataLoaded ? coinState.coin : initialCoin;
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${coin.name ?? 'Coin'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (coin.symbol != null) TextSpan(
                    text: ' (${coin.symbol!.toUpperCase()})',
                    style: const TextStyle(
                      color: Colors.grey, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,        
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.arrow_left, color: Colors.white),
              onPressed: () => context.router.pop(),
            ),
            actions: [
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final isFavorite = state is FavouriteStatusLoaded && state.isFavorite;
                  final isLoading = state is FavouriteLoading;

                  return IconButton(
                    icon: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Constants.formBlueColor,
                            ),
                          )
                        : Icon(
                            isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                            color: Colors.white,
                          ),
                    onPressed: isLoading
                        ? null
                        : () => context.read<FavouriteCubit>().toggleFavorite(),
                  );
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                CoinHeader(coin: coin),
                const SizedBox(height: 25),
                PortfolioSection(coin: coin),
                const SizedBox(height: 25),
                BlocBuilder<ChartCubit, ChartState>(
                  builder: (context, chartState) {
                    if (chartState is ChartLoaded) {
                      return AnimatedCoinChart(
                        chartData: chartState.chartData.map((e) => FlSpot(
                          (e['time'] as num).toDouble(), 
                          (e['price'] as num).toDouble()
                        )).toList(),
                        isPositive: chartState.isPositive,
                        timeframe: chartState.timeframe,
                      );
                    }
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator(color: Constants.formBlueColor)),
                    );
                  },
                ),
                const SizedBox(height: 25),
                Center(child: TimeframeSelector(initialCoin: initialCoin)),
                const SizedBox(height: 25),
                MarketStats(coin: coin),
              ],
            ),
          ),
        );
      },
    );
  }
}
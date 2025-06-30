// features/home/presentation/screens/coin_dashboard.dart
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
          create: (context) => serviceLocator<ChartCubit>()..loadChart(coinId, '1D'),
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
            actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
            backgroundColor: Colors.black,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: coin.name ?? 'Coin',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (coin.symbol != null) TextSpan(
                    text: " (${coin.symbol!.toUpperCase()})",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () => context.router.pop(),
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildHeader(coinState, coin),
                const SizedBox(height: 20),
                _buildPortfolioSection(coinState, coin),
                const SizedBox(height: 20),
                BlocBuilder<ChartCubit, ChartState>(
                  builder: (context, chartState) {
                    return _buildChartSection(chartState);
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child:  _buildTimeframeSelector(),
                ),
                const SizedBox(height: 20),
                _buildMarketStats(coin),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(CoinDataState state, CoinModel coin) {
    final isPositive = coin.priceChangePercentage24h != null && 
                      coin.priceChangePercentage24h! >= 0;
                      
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${_formatNumber(coin.currentPrice ?? 0)}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1
                  ),
                ),
                Text(
                  '${isPositive ? '+' : ''}${_formatNumber(coin.priceChange24h ?? 0)} '
                  '(${coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '0.00'}%)',
                  style: TextStyle(
                    fontSize: 16,
                    color: isPositive ? Colors.greenAccent : Colors.red,
                    letterSpacing: -0.5
                  ),
                )
              ],
            ),
            
            if (coin.image != null) 
            Image.network(
              coin.image!, 
              width: 50, 
              height: 50,
              errorBuilder: (context, error, stackTrace) => 
                const Icon(Icons.currency_bitcoin, color: Colors.white),
            )
            else
              const Icon(Icons.currency_bitcoin, color: Colors.white, size: 30),
          ],
        ),
      ],
    );
  }

  String _formatNumber(double num) {
    return num.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  String _formatCount(double num) {
    final formatted = _formatNumber(num);
    return formatted.endsWith('.00') 
        ? formatted.substring(0, formatted.length - 3)
        : formatted;
  }

  Widget _buildPortfolioSection(CoinDataState state, CoinModel coin) {
    final coinAmount = 12.43;
    final coinValue = coinAmount * (coin.currentPrice ?? 0);
    final netCost = coinValue * 0.75;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Portfolio",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: -0.5
              ),
            ),
            Text(
              "12,43 ${coin.symbol?.toUpperCase() ?? ''}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5
              ),
            )
          ], 
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Market Value",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: -0.5
              ),
            ),
            Text(
              "\$${_formatNumber(coinValue)}", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5
              ),
            )
          ], 
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Net Cost",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: -0.5
              ),
            ),
            Text(
              "\$${_formatNumber(netCost)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5
              ),
            )
          ], 
        ),
      ],
    );
  }

  Widget _buildChartSection(ChartState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: (state is ChartLoaded)
                ? LineChart(
                    _mainChartData(state.chartData, state.isPositive, state.timeframe),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  LineChartData _mainChartData(
  List<Map<String, dynamic>> chartData,
  bool isPositive,
  String timeframe,
  ) {
    if (timeframe == '1H' && chartData.isNotEmpty) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final oneHourAgo = now - (60 * 60 * 1000);
      chartData = chartData.where((point) => 
          (point['time'] as num).toDouble() >= oneHourAgo).toList();
    }

    final spots = chartData.map((point) {
      return FlSpot(
        (point['time'] as num).toDouble(),
        (point['price'] as num).toDouble(),
      );
    }).toList();

    final minY = spots.isNotEmpty 
        ? spots.map((e) => e.y).reduce((a, b) => a < b ? a : b)
        : 0.0;
    final maxY = spots.isNotEmpty 
        ? spots.map((e) => e.y).reduce((a, b) => a > b ? a : b)
        : 0.0;

    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: spots.isNotEmpty ? spots.first.x : 0.0,
      maxX: spots.isNotEmpty ? spots.last.x : 0.0,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: isPositive ? Colors.green : Colors.red,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: isPositive 
                ? Colors.greenAccent.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector() {
    final timeframes = ['1H', '1D', '1W', '1M', '6M', '1Y', 'ALL'];
    return BlocBuilder<ChartCubit, ChartState>(
      builder: (context, state) {
        String? selectedTimeframe;
        if (state is ChartLoaded) {
          selectedTimeframe = state.timeframe;
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeframes.map((tf) {
            return GestureDetector(
              onTap: () => context.read<ChartCubit>().loadChart(
                initialCoin.id ?? 'bitcoin', 
                tf
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                decoration: BoxDecoration(
                  color: selectedTimeframe == tf ? Constants.formBlueColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tf,
                  style: TextStyle(
                    color: selectedTimeframe == tf ? Colors.white : Colors.grey[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildMarketStats(CoinModel coin) {
    final currentPrice = coin.currentPrice ?? 1;
    final marketCapInCoins = (coin.marketCap ?? 0) / (currentPrice != 0 ? currentPrice : 1);

    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3, 
            crossAxisSpacing: 10,
            mainAxisSpacing: 16, 
            children: [
              _buildStatItem(
                'Market Cap',
                '${_formatCount(marketCapInCoins)} ${coin.symbol?.toUpperCase() ?? ''}',
                maxLines: 2, 
              ),
              _buildStatItem(
                'Volume (24h)', 
                '\$${_formatNumber(coin.totalVolume?.toDouble() ?? 0)}',
                maxLines: 2,
              ),
              _buildStatItem(
                'Available Supply', 
                '${_formatCount(coin.circulatingSupply ?? 0)} ${coin.symbol?.toUpperCase() ?? ''}',
                maxLines: 2,
              ),
              _buildStatItem(
                'Total Supply', 
                '${_formatCount(coin.totalSupply ?? 0)} ${coin.symbol?.toUpperCase() ?? ''}',
                maxLines: 2,
              ),
              _buildStatItem(
                'Low (24h)', 
                '\$${_formatNumber(coin.low24h ?? 0)}',
                maxLines: 1,
              ),
              _buildStatItem(
                'High (24h)', 
                '\$${_formatNumber(coin.high24h ?? 0)}',
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14, 
            letterSpacing: -0.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ), 
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
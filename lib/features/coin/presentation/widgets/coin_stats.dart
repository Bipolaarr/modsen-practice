import 'package:flutter/material.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'number_formatter.dart';

class MarketStats extends StatelessWidget {
  final CoinModel coin;

  const MarketStats({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final price = coin.currentPrice ?? 1;
    final capCoins = (coin.marketCap ?? 0) / price;
    
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 16,
      children: [
        _stat('Market Cap', '${formatNumber(capCoins, fractionDigits: 0)} ${coin.symbol?.toUpperCase() ?? ''}'),
        _stat('Volume (24h)', '\$${formatNumber(coin.totalVolume)}'),
        _stat('Available Supply', '${formatNumber(coin.circulatingSupply, fractionDigits: 0)} ${coin.symbol?.toUpperCase() ?? ''}'),
        _stat('Total Supply', '${formatNumber(coin.totalSupply, fractionDigits: 0)} ${coin.symbol?.toUpperCase() ?? ''}'),
        _stat('Low (24h)', '\$${formatNumber(coin.low24h)}'),
        _stat('High (24h)', '\$${formatNumber(coin.high24h)}'),
      ],
    );
  }

  Widget _stat(String title, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title, style: const TextStyle(color: Colors.grey, letterSpacing: -0.5, fontSize: 16)), 
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5, fontSize: 16))
    ],
  );
}
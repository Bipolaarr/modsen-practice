import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'number_formatter.dart';

class CoinHeader extends StatelessWidget {
  final CoinModel coin;

  const CoinHeader({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final change = coin.priceChange24h ?? 0;
    final percent = coin.priceChangePercentage24h ?? 0;
    final isPositive = percent >= 0;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$${formatNumber(coin.currentPrice)}',
              style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: -1),
            ),
            Text(
              '${isPositive ? '+' : ''}${formatNumber(change)} (${isPositive ? '+' : ''}${percent.toStringAsFixed(2)}%)',
              style: TextStyle(color: isPositive ? Colors.greenAccent : Colors.red, letterSpacing: -0.5, fontSize: 16),
            ),
          ],
        ),
        coin.image != null
            ? Image.network(coin.image!, width: 40, height: 40)
            : const Icon(Icons.currency_bitcoin, color: Colors.white, size: 30),
      ],
    );
  }
}
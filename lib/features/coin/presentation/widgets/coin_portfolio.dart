import 'package:flutter/material.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'number_formatter.dart';

class PortfolioSection extends StatelessWidget {
  final CoinModel coin;

  const PortfolioSection({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    const amount = 12.43;
    final value = (coin.currentPrice ?? 0) * amount;
    final cost = value * 0.75;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _labelValue('Portfolio', '${formatNumber(amount)} ${coin.symbol?.toUpperCase() ?? ''}'),
        _labelValue('Market Value', '\$${formatNumber(value)}'),
        _labelValue('Net Cost', '\$${formatNumber(cost)}'),
      ],
    );
  }

  Widget _labelValue(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey, letterSpacing: -0.5, fontSize: 16)),
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5, fontSize: 16)),
    ],
  );
}
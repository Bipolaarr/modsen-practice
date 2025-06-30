// features/home/presentation/widgets/coin_tile.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';

class CoinTile extends StatelessWidget {
  final CoinModel coin;
  
  const CoinTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final priceChange = coin.priceChange24h ?? 0;
    final percentChange = coin.priceChangePercentage24h ?? 0;
    
    return ListTile(
      onTap: () => context.router.push(
        CoinRoute(coinId: coin.id!, initialCoin: coin)
      ),
      leading: coin.image != null 
          ? Image.network(coin.image!, width: 30, height: 30)
          : const Icon(Icons.currency_bitcoin, color: Colors.white),
      title: Text(
        coin.name ?? 'Unknown Coin',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -1
        ),
      ),
      subtitle: Text(
        coin.symbol?.toUpperCase() ?? '',
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          letterSpacing: -0.5
        )
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${coin.currentPrice?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -1
            )
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${priceChange >= 0 ? '+' : '-'}\$${priceChange.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: priceChange >= 0 ? Colors.greenAccent : Colors.red,
                  fontSize: 14,
                  letterSpacing: -0.5
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${percentChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: percentChange >= 0 ? Colors.greenAccent : Colors.red,
                  fontSize: 14,
                  letterSpacing: -0.5
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
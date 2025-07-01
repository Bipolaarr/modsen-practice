import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/features/coin/presentation/bloc/chart_cubit.dart';
import 'package:practice_app/features/coin/presentation/bloc/chart_state.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';

class TimeframeSelector extends StatelessWidget {
  final CoinModel initialCoin;

  const TimeframeSelector({super.key, required this.initialCoin});

  @override
  Widget build(BuildContext context) {
    const frames = ['1H', '1D', '1W', '1M', '6M', '1Y', 'ALL'];
    
    return Wrap(
      spacing: 8,
      children: frames.map((tf) {
        return GestureDetector(
          onTap: () => context.read<ChartCubit>().loadChart(initialCoin.id ?? 'bitcoin', tf),
          child: BlocBuilder<ChartCubit, ChartState>(
            builder: (context, state) {
              final selected = state is ChartLoaded ? state.timeframe : '1D';
              final active = selected == tf;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? Constants.formBlueColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(tf, style: TextStyle(color: active ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
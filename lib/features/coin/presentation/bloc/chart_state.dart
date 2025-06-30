// features/coin/presentation/bloc/chart_state.dart
import 'package:equatable/equatable.dart';

abstract class ChartState extends Equatable {
  const ChartState();
}

class ChartInitial extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoading extends ChartState {
  @override
  List<Object> get props => [];
}

class ChartLoaded extends ChartState {
  final List<Map<String, dynamic>> chartData;
  final int days;
  final String timeframe;  
  final bool isPositive;

  const ChartLoaded({
    required this.chartData,
    required this.days,
    required this.timeframe,
    required this.isPositive,
  });

  @override
  List<Object> get props => [chartData, days, timeframe, isPositive];
}

class ChartError extends ChartState {
  final String message;

  const ChartError(this.message);

  @override
  List<Object> get props => [message];
}
// features/home/presentation/cubit/chart_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:practice_app/features/coin/domain/repositories/chart_repository.dart';
import 'package:practice_app/features/coin/presentation/bloc/chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  final ChartRepository repository;

  ChartCubit(this.repository) : super(ChartInitial());

  Future<void> loadChart(String coinId, String timeframe) async {
    emit(ChartLoading());
    try {
      final days = _getDaysFromTimeframe(timeframe);
      final chartData = await repository.getCoinChart(coinId, days);
      final isPositive = chartData.isNotEmpty
          ? chartData.last['price'] > chartData.first['price']
          : true;
      emit(ChartLoaded(
        chartData: chartData,
        days: days,
        timeframe: timeframe,
        isPositive: isPositive,
      ));
    } catch (e) {
      emit(ChartError(e.toString()));
    }
  }

  int _getDaysFromTimeframe(String timeframe) {
    switch (timeframe) {
      case '1H': return 1;
      case '1D': return 1;
      case '1W': return 7;
      case '1M': return 30;
      case '6M': return 180;
      case '1Y': return 365;
      case 'ALL': return 365 * 5;
      default: return 1;
    }
  }
}
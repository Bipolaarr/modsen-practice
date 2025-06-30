// features/coin/data/repositories/chart_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:practice_app/features/coin/domain/repositories/chart_repository.dart';
import 'package:practice_app/features/home/data/sources/coins_remote_service.dart';

class ChartRepositoryImpl implements ChartRepository {
  final CoinsRemoteService remoteService;
  final String apiKey;

  ChartRepositoryImpl({required this.remoteService, required this.apiKey});

  @override
  Future<List<Map<String, dynamic>>> getCoinChart(String id, int days) async {
    try {

      final interval = days == 1 ? 'minute' : 'daily';
      
      final response = await remoteService.coinMarketChart(
        id,
        apiKey,
        vs_currency: 'usd',
        days: days,
        interval: interval, 
      );
      
      final List<dynamic> prices = response['prices'];
      return prices.map((e) => {'time': e[0], 'price': e[1]}).toList();

    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load chart data');
    }
  }
}
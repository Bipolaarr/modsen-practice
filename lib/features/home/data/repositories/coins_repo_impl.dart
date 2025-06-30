// features/home/data/repositories/coins_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:practice_app/core/errors/exceptions.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/data/sources/coins_remote_service.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';

class CoinsRepositoryImplementation implements CoinsRepository {
  CoinsRepositoryImplementation(this._source, this._apiKey);
  final CoinsRemoteService _source;
  final String _apiKey;
  
  @override
  Future<List<CoinModel>> coinsListMarketData({
    int page = 1,
    PriceChangePercentageTimeframes timeframe = PriceChangePercentageTimeframes.twentyFourHours
  }) async {
    try {
      return await _source.coinsListWithMarketData(
        _apiKey,
        page: page,
        priceChangePercentageTimeframe: _getTimeframeValue(timeframe)
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  String _getTimeframeValue(PriceChangePercentageTimeframes timeframe) {
    const values = [
      '1h',
      '24h',
      '7d',
      '14d',
      '30d',
      '200d',
      '1y'
    ];
    return values[timeframe.index];
  }
}
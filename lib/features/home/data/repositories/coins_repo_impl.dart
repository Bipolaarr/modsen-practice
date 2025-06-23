import 'package:dio/dio.dart';
import 'package:practice_app/core/errors/exceptions.dart'; // Add this import
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/data/sources/coins_remote_service.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';

const List<String> _periods = [
  '1h',
  '24h',
  '7d',
  '14d',
  '30d',
  '200d',
  '1y'
];

String getValue(PriceChangePercentageTimeframes timeframe){
  return _periods[timeframe.index];
}

class CoinsRepositoryImplementation implements CoinsRepository{
  CoinsRepositoryImplementation(CoinsRemoteService source,String apiKey) : _source = source, _apikey = apiKey;
  final CoinsRemoteService _source;
  final String _apikey;
  
  @override
  Future<List<CoinModel>> coinsListMarketData({int page = 1,PriceChangePercentageTimeframes timeframe = PriceChangePercentageTimeframes.twentyFourHours}) async {
    try{
      final res = await _source.coinsListWithMarketData(
        _apikey,
        page: page,
        priceChangePercentageTimeframe: getValue(timeframe)
      );
      return res;
    }
    on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException();
      }
      rethrow;
    }
    catch (e) {
      rethrow;
    }
  }

}
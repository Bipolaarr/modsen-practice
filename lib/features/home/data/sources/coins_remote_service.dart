import 'package:dio/dio.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:retrofit/retrofit.dart';

part 'coins_remote_service.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class CoinsRemoteService {
  factory CoinsRemoteService(Dio dio, {String baseUrl}) = _CoinsRemoteService;

  @GET('/ping')
  Future<String> ping(@Query(Constants.apiKeyParam) String apiKey);
  @GET('/coins/list')
  Future<List<CoinModel>> coinsList(@Query(Constants.apiKeyParam) String apiKey);
  @GET('/coins/markets')
  Future<List<CoinModel>> coinsListWithMarketData(
      @Query(Constants.apiKeyParam) String apiKey,
      {
        @Query('vs_currency') String vs_currency = 'usd',
        @Query('per_page') int per_page = 100,
        @Query('page') int page = 1,
        @Query('locale') String locale = 'en',
        @Query('price_change_percentage') String priceChangePercentageTimeframe = '24h',
      }
      );
}
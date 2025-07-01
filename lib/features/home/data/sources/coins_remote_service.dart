import 'package:dio/dio.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:retrofit/retrofit.dart';

part 'coins_remote_service.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class CoinsRemoteService {
  factory CoinsRemoteService(Dio dio, {String baseUrl}) = _CoinsRemoteService;

  @GET('/coins/markets')
  Future<List<CoinModel>> coinsListWithMarketData(
    @Query('x_cg_demo_api_key') String apiKey, {
    @Query('vs_currency') String vs_currency = 'usd',
    @Query('per_page') int per_page = 100,
    @Query('page') int page = 1,
    @Query('locale') String locale = 'en',
    @Query('price_change_percentage') String priceChangePercentageTimeframe = '24h',
  });
  
  @GET('/coins/{id}/market_chart')
  Future<dynamic> coinMarketChart(
    @Path('id') String id,
    @Query('x_cg_demo_api_key') String apiKey, {
    @Query('vs_currency') String vs_currency = 'usd',
    @Query('days') int days = 1,
    @Query('interval') String interval = 'daily',
  });

  @GET('/coins/markets')
  Future<List<CoinModel>> getCoinsByIds(
    @Query('x_cg_demo_api_key') String apiKey, {
    @Query('vs_currency') String vs_currency = 'usd',
    @Query('ids') required String ids,
    @Query('per_page') int per_page = 250,
    @Query('price_change_percentage') String priceChangePercentageTimeframe = '24h',
  });

}
import 'package:practice_app/features/home/data/models/coin_model.dart';

enum PriceChangePercentageTimeframes {
  oneHour,
  twentyFourHours,
  sevenDays,
  fourteenDays,
  thirtyDays,
  twoHundredDays,
  oneYear,
}

abstract interface class CoinsRepository{
 
  Future<List<CoinModel>> coinsListMarketData({int page = 1,PriceChangePercentageTimeframes timeframe = PriceChangePercentageTimeframes.twentyFourHours});
}
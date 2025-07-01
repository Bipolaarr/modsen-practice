// features/home/data/models/coin_market_chart_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'chart_model.g.dart';

@JsonSerializable()
class CoinMarketChartModel {
  final List<List<double>> prices;

  CoinMarketChartModel({required this.prices});

  factory CoinMarketChartModel.fromJson(Map<String, dynamic> json) =>
      _$CoinMarketChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinMarketChartModelToJson(this);
}
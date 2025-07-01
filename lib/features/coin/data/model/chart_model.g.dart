// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinMarketChartModel _$CoinMarketChartModelFromJson(
        Map<String, dynamic> json) =>
    CoinMarketChartModel(
      prices: (json['prices'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
    );

Map<String, dynamic> _$CoinMarketChartModelToJson(
        CoinMarketChartModel instance) =>
    <String, dynamic>{
      'prices': instance.prices,
    };

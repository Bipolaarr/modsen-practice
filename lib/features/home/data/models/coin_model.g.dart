// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinModel _$CoinModelFromJson(Map<String, dynamic> json) => CoinModel(
      json['id'] as String?,
      json['symbol'] as String?,
      json['name'] as String?,
      json['image'] as String?,
      (json['current_price'] as num?)?.toDouble(),
      (json['market_cap'] as num?)?.toDouble(),
      (json['market_cap_rank'] as num?)?.toInt(),
      (json['fully_diluted_valuation'] as num?)?.toInt(),
      (json['total_volume'] as num?)?.toInt(),
      (json['high_24h'] as num?)?.toDouble(),
      (json['low_24h'] as num?)?.toDouble(),
      (json['price_change_24h'] as num?)?.toDouble(),
      (json['price_change_percentage_24h'] as num?)?.toDouble(),
      (json['market_cap_change_24h'] as num?)?.toDouble(),
      (json['market_cap_change_percentage_24h'] as num?)?.toDouble(),
      (json['circulating_supply'] as num?)?.toDouble(),
      (json['total_supply'] as num?)?.toDouble(),
      (json['max_supply'] as num?)?.toDouble(),
      (json['ath'] as num?)?.toDouble(),
      (json['ath_change_percentage'] as num?)?.toDouble(),
      json['ath_date'] as String?,
      (json['atl'] as num?)?.toDouble(),
      (json['atl_change_percentage'] as num?)?.toDouble(),
      json['atl_date'] as String?,
      json['roi'] as Map<String, dynamic>?,
      json['lastUpdated'] as String?,
      json['platforms'] as String?,
    );

Map<String, dynamic> _$CoinModelToJson(CoinModel instance) => <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'market_cap': instance.marketCap,
      'market_cap_rank': instance.marketCapRank,
      'fully_diluted_valuation': instance.fullyDilutedValuation,
      'total_volume': instance.totalVolume,
      'high_24h': instance.high24h,
      'low_24h': instance.low24h,
      'price_change_24h': instance.priceChange24h,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'market_cap_change_24h': instance.marketCapChange24h,
      'market_cap_change_percentage_24h': instance.marketCapChangePercentage24h,
      'circulating_supply': instance.circulatingSupply,
      'total_supply': instance.totalSupply,
      'max_supply': instance.maxSupply,
      'ath': instance.ath,
      'ath_change_percentage': instance.athChangePercentage,
      'ath_date': instance.athDate,
      'atl': instance.atl,
      'atl_change_percentage': instance.atlChangePercentage,
      'atl_date': instance.atlDate,
      'roi': instance.roi,
      'lastUpdated': instance.lastUpdated,
      'platforms': instance.platforms,
    };

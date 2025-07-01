// features/favorites/data/models/favorite_coin_model.dart
import 'package:isar/isar.dart';

part 'favourite_coin_model.g.dart';

@collection
class FavouriteCoinModel {
  Id id = Isar.autoIncrement;
  final String userId; // Firebase UID
  final String coinId;

  FavouriteCoinModel({
    required this.userId,
    required this.coinId,
  });
}
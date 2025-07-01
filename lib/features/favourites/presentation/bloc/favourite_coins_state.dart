import 'package:practice_app/features/home/data/models/coin_model.dart';

sealed class FavouriteCoinsState {}

class FavouriteCoinsInitial extends FavouriteCoinsState {}

class FavouriteCoinsLoading extends FavouriteCoinsState {}

class FavouriteCoinsLoaded extends FavouriteCoinsState {
  final List<CoinModel> coins;
  
  FavouriteCoinsLoaded({required this.coins});
}

class FavouriteCoinsError extends FavouriteCoinsState {
  final String message;
  FavouriteCoinsError(this.message);
}
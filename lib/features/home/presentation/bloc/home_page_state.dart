
import 'package:practice_app/features/home/data/models/coin_model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CoinModel> coins;
  HomeLoaded(this.coins);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
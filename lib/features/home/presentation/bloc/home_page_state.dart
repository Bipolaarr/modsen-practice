// features/home/presentation/bloc/home_page_state.dart
import 'package:practice_app/features/home/data/models/coin_model.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CoinModel> coins;
  final bool hasReachedMax;
  
  HomeLoaded({required this.coins, required this.hasReachedMax});
}

class HomeLoadingMore extends HomeState {
  final List<CoinModel> coins;
  
  HomeLoadingMore({required this.coins});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
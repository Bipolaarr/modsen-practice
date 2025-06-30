import 'package:equatable/equatable.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';

abstract class CoinDataState extends Equatable {
  const CoinDataState();
}

class CoinDataInitial extends CoinDataState {
  @override
  List<Object> get props => [];
}

class CoinDataLoading extends CoinDataState {
  @override
  List<Object> get props => [];
}

class CoinDataLoaded extends CoinDataState {
  final CoinModel coin;

  const CoinDataLoaded(this.coin);

  @override
  List<Object> get props => [coin];
}

class CoinDataError extends CoinDataState {
  final String message;

  const CoinDataError(this.message);

  @override
  List<Object> get props => [message];
}
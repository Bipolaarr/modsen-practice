// features/home/presentation/cubit/coin_data_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:practice_app/features/coin/presentation/bloc/coin_data_state.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';

class CoinDataCubit extends Cubit<CoinDataState> {
  final CoinsRepository repository;

  CoinDataCubit(this.repository) : super(CoinDataInitial());

  Future<void> fetchCoinData(String coinId) async {
    emit(CoinDataLoading());
    try {
      final coins = await repository.coinsListMarketData();
      final coin = coins.firstWhere((c) => c.id == coinId);
      emit(CoinDataLoaded(coin));
    } catch (e) {
      emit(CoinDataError(e.toString()));
    }
  }
}
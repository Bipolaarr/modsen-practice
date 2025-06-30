// features/home/presentation/cubit/home_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:practice_app/core/errors/exceptions.dart';
import 'package:practice_app/features/home/data/models/coin_model.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CoinsRepository _coinsRepository;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  static const int _pageSize = 100; 

  HomeCubit(this._coinsRepository) : super(HomeInitial());

  Future<void> loadInitialCoins() async {
    emit(HomeLoading());
    try {
      _currentPage = 1;
      _hasReachedMax = false;

      final raw = await _coinsRepository.coinsListMarketData(
        page: _currentPage,
        timeframe: PriceChangePercentageTimeframes.twentyFourHours,
      );
      final coins = raw.cast<CoinModel>();

      emit(HomeLoaded(
        coins: coins,
        hasReachedMax: coins.length < _pageSize,
      ));
      _currentPage++;
    } on TimeoutException {
      emit(HomeError("Timeout occurred"));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadMoreCoins() async {
    if (_hasReachedMax || state is HomeLoadingMore) return;

    try {
      final currentCoins = (state is HomeLoaded)
          ? (state as HomeLoaded).coins
          : <CoinModel>[];

      emit(HomeLoadingMore(coins: currentCoins));

      final rawNew = await _coinsRepository.coinsListMarketData(
        page: _currentPage,
        timeframe: PriceChangePercentageTimeframes.twentyFourHours,
      );
      final newCoins = rawNew.cast<CoinModel>();

      if (newCoins.isEmpty) {
        _hasReachedMax = true;
        emit(HomeLoaded(coins: currentCoins, hasReachedMax: true));
        return;
      }

      final updated = [...currentCoins, ...newCoins];
      _hasReachedMax = newCoins.length < _pageSize;

      emit(HomeLoaded(coins: updated, hasReachedMax: _hasReachedMax));
      _currentPage++;
    } catch (e) {
      if (state is HomeLoadingMore) {
        final previous = (state as HomeLoadingMore).coins;
        emit(HomeLoaded(coins: previous, hasReachedMax: _hasReachedMax));
      }
    }
  }
}

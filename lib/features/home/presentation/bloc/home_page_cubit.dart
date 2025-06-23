// features/home/presentation/cubit/home_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:practice_app/core/errors/exceptions.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CoinsRepository _coinsRepository;
  
  HomeCubit(this._coinsRepository) : super(HomeInitial());

  Future<void> loadCoins() async {
    emit(HomeLoading());
    try {
      final coins = await _coinsRepository.coinsListMarketData(
        timeframe: PriceChangePercentageTimeframes.twentyFourHours
      );
      emit(HomeLoaded(coins));
    } on TimeoutException {
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
import 'package:bloc/bloc.dart';
import 'package:practice_app/core/errors/exceptions.dart';
import 'package:practice_app/features/favourites/domain/repositories/favourites_repository.dart';
import 'package:practice_app/features/favourites/presentation/bloc/favourite_coins_state.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';

class FavouriteCoinsCubit extends Cubit<FavouriteCoinsState> {
  final FavouritesRepository _favRepo;
  final CoinsRepository _coinsRepo;

  FavouriteCoinsCubit({
    required FavouritesRepository favRepo,
    required CoinsRepository coinsRepo,
  })  : _favRepo = favRepo,
        _coinsRepo = coinsRepo,
        super(FavouriteCoinsInitial());

  Future<void> loadFavorites() async {
    emit(FavouriteCoinsLoading());
    try {
      final favoriteIds = await _favRepo.getFavourites();
      if (favoriteIds.isEmpty) {
        emit(FavouriteCoinsLoaded(coins: []));
        return;
      }

      // Get actual coin data from repository
      final coins = await _coinsRepo.getCoinsByIds(favoriteIds);
      emit(FavouriteCoinsLoaded(coins: coins));
    } on TimeoutException {
      emit(FavouriteCoinsError("Timeout occurred"));
    } catch (e) {
      emit(FavouriteCoinsError(e.toString()));
    }
  }

  Future<void> refreshFavorites() async {
    await loadFavorites();
  }
}
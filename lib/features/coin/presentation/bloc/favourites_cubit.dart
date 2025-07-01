// features/favourites/presentation/cubit/favorite_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:practice_app/features/coin/presentation/bloc/favourite_state.dart';
import 'package:practice_app/features/favourites/domain/repositories/favourites_repository.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouritesRepository repository;
  final String coinId;

  FavouriteCubit({
    required this.repository,
    required this.coinId,
  }) : super(FavouriteInitial()) {
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    emit(FavouriteLoading());
    try {
      final isFavorite = await repository.isFavourite(coinId);
      emit(FavouriteStatusLoaded(isFavorite));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavorite() async {
    try {
      emit(FavouriteLoading());
      await repository.toggleStatus(coinId);
      
      // Get updated status after toggle
      final newStatus = await repository.isFavourite(coinId);
      emit(FavouriteStatusLoaded(newStatus));
    } catch (e) {
      emit(FavouriteError(e.toString()));
      // Re-fetch status after error
      final currentStatus = await repository.isFavourite(coinId);
      emit(FavouriteStatusLoaded(currentStatus));
    }
  }
}
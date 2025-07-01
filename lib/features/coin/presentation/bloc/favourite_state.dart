abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteStatusLoaded extends FavouriteState {
  final bool isFavorite;
  FavouriteStatusLoaded(this.isFavorite);
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
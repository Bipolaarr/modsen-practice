abstract interface class FavouritesRepository {

  Future<void> toggleStatus(String coinId);
  Future<bool> isFavourite(String coinId);
  Future<List<String>> getFavourites();

}
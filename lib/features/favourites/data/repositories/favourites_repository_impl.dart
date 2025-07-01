import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/favourites/data/services/favourite_coins_service.dart';
import 'package:practice_app/features/favourites/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository{
  @override
  Future<List<String>> getFavourites() async {
      return await serviceLocator<AbstractFavouriteCoinsService>().getFavourites();
  }

  @override
  Future<bool> isFavourite(String coinId) async {
    return await serviceLocator<AbstractFavouriteCoinsService>().isFavourite(coinId);
  }

  @override
  Future<void> toggleStatus(String coinId) async {
   return await serviceLocator<AbstractFavouriteCoinsService>().toggleStatus(coinId);
  } 



}
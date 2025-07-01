import 'package:firebase_auth/firebase_auth.dart';
import 'package:isar/isar.dart';
import 'package:practice_app/features/favourites/data/models/favourite_coin_model.dart';

abstract interface class AbstractFavouriteCoinsService {


  Future<void> toggleStatus(String coinId);
  Future<bool> isFavourite(String coinId);
  Future<List<String>> getFavourites();

}

class FavoritesService implements AbstractFavouriteCoinsService{
  final Isar isar;
  final FirebaseAuth firebaseAuth;

  FavoritesService(this.isar, this.firebaseAuth);

  @override
  Future<List<String>> getFavourites() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return [];
    
    final favorites = await isar.favouriteCoinModels
        .filter()
        .userIdEqualTo(user.uid)
        .findAll();
    
    return favorites.map((f) => f.coinId).toList();
  }
  
  @override
  Future<bool> isFavourite(String coinId) async {
    final user = firebaseAuth.currentUser;
    if (user == null) return false;
    
    final favorite = await isar.favouriteCoinModels
        .filter()
        .userIdEqualTo(user.uid)
        .coinIdEqualTo(coinId)
        .findFirst();
    
    return favorite != null;
  }
  
  @override
  Future<void> toggleStatus(String coinId) async {
   final user = firebaseAuth.currentUser;
    if (user == null) return;

    final existing = await isar.favouriteCoinModels
        .filter()
        .userIdEqualTo(user.uid)
        .coinIdEqualTo(coinId)
        .findFirst();

    await isar.writeTxn(() async {
      if (existing != null) {
        await isar.favouriteCoinModels.delete(existing.id);
      } else {
        await isar.favouriteCoinModels.put(FavouriteCoinModel(
          userId: user.uid,
          coinId: coinId,
        ));
      }
    });
  }
}
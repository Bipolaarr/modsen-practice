import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/data/sources/isar_local_service.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';

class BiometricsRepoImplementation implements BiometricsRepository{
  @override
  Future<bool> authenticateWithBiometrics() async {
    return await serviceLocator<AbstractIsarLocalService>().authenticateWithBiometrics();
  }

  @override
  Future<void> deleteUser() async {
    return await serviceLocator<AbstractIsarLocalService>().deleteUser();
  }

  @override
  Future<UserModel?> getSavedUser() async {
    return await serviceLocator<AbstractIsarLocalService>().getSavedUser();
  }

  @override
  Future<void> initialize() async {
    return await serviceLocator<AbstractIsarLocalService>().initialize();
  }

  @override
  Future<bool> isUserExists() async {
    return await serviceLocator<AbstractIsarLocalService>().isUserExists();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    return await serviceLocator<AbstractIsarLocalService>().saveUser(user);
  }
    
  

}
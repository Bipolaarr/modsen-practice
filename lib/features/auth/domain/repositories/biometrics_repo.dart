import 'package:practice_app/features/auth/data/models/user_model.dart';

abstract interface class BiometricsRepository {

  Future<bool> isBiometricAuthAvailable();
  Future<void> initialize();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser();
  Future<bool> isUserExists();
  Future<UserModel?> getSavedUser();
  Future<bool> authenticateWithBiometrics();

}
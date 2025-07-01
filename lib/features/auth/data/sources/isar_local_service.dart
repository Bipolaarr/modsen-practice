import 'package:isar/isar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/favourites/data/models/favourite_coin_model.dart';

abstract class AbstractIsarLocalService {
  Future<void> initialize();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser();
  Future<bool> isUserExists();
  Future<UserModel?> getSavedUser();
  Future<bool> authenticateWithBiometrics();
  Future<bool> isBiometricAuthAvailable();
}

class IsarLocalService extends AbstractIsarLocalService {
  late Isar isar;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserModelSchema, FavouriteCoinModelSchema],
      directory: dir.path,
    );
  }

  @override
  Future<void> deleteUser() async {
    await isar.writeTxn(() => isar.userModels.clear());
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await isar.writeTxn(() => isar.userModels.clear());
    await isar.writeTxn(() => isar.userModels.put(user));
  }

  @override
  Future<bool> isUserExists() async {
    return (await isar.userModels.count() > 0);
  }

  @override
  Future<UserModel?> getSavedUser() async {
    return await isar.userModels.where().findFirst();
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      final canAuthenticate = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      
      if (!canAuthenticate || !isDeviceSupported) {
        return false;
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: availableBiometrics.contains(BiometricType.face)
            ? "Authenticate with Face ID"
            : availableBiometrics.contains(BiometricType.fingerprint)
                ? "Authenticate with Touch ID"
                : "Authenticate to access your account",
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isBiometricAuthAvailable() async {
    try {
      final canAuthenticate = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      final hasBiometrics = await _localAuth.getAvailableBiometrics();
      
      return canAuthenticate && isSupported && hasBiometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
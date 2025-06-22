import 'package:isar/isar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';

abstract class AbstractIsarLocalService {

  Future<void> initialize();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser();
  Future<bool> isUserExists();
  Future<UserModel?> getSavedUser();
  Future<bool> authenticateWithBiometrics();

}

class IsarLocalService  extends AbstractIsarLocalService {

  late Isar _isar;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<void> initialize() async {

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserModelSchema],
      directory: dir.path);

  }

  @override
  Future<void> deleteUser() async {

    await _isar.writeTxn(() => _isar.userModels.clear());

  }

  @override
  Future<void> saveUser(UserModel user) async {

    await _isar.writeTxn(() => _isar.userModels.clear());
    await _isar.writeTxn(() => _isar.userModels.put(user));


  }

  @override
  Future<bool> isUserExists() async {
    return (await _isar.userModels.count() > 0);
  }

  @override
  Future<UserModel?> getSavedUser() async {

    return await _isar.userModels.where().findFirst();

  }

  Future<bool> authenticateWithBiometrics() async {

    
    return await _localAuth.authenticate(
      localizedReason: "Authenticate to get access",
      options: AuthenticationOptions(
        biometricOnly: true,
        useErrorDialogs: true
      )

    );

  }





}
import 'package:get_it/get_it.dart';
import 'package:practice_app/core/net/dio_client.dart';
import 'package:practice_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:practice_app/features/auth/data/repositories/biometrics_repo_impl.dart';
import 'package:practice_app/features/auth/data/sources/firebase_remote_service.dart';
import 'package:practice_app/features/auth/data/sources/isar_local_service.dart';
import 'package:practice_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/quick_auth_check_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/quick_auth_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signup_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {

  final isarService = IsarLocalService();
  await isarService.initialize();

  serviceLocator.registerSingleton(() => DioClient());
  
  serviceLocator.registerSingleton<AbstractFirebaseRemoteService>(FirebaseRemoteService());
  serviceLocator.registerSingleton<AuthRepository>(AuthRepoImplementation());
  serviceLocator.registerSingleton<AbstractIsarLocalService>(isarService);
  serviceLocator.registerSingleton<BiometricsRepository>(BiometricsRepoImplementation());

  serviceLocator.registerSingleton<SignInUsecase>(SignInUsecase());
  serviceLocator.registerSingleton<SignUpUsecase>(SignUpUsecase());
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase());
  serviceLocator.registerSingleton<QuickAuthCheckUsecase>(QuickAuthCheckUsecase());
  serviceLocator.registerSingleton<QuickAuthUsecase>(QuickAuthUsecase());

}




import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_app/core/net/dio_client.dart';
import 'package:logger/logger.dart';
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
import 'package:practice_app/features/home/data/repositories/coins_repo_impl.dart';
import 'package:practice_app/features/home/data/sources/coins_remote_service.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {

  var logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
  );

  await dotenv.load(fileName: ".env");
  final _apiKey = dotenv.env['CG_APIKEY'];
  if (_apiKey == null) logger.e("WTHELLY");

  final isarService = IsarLocalService();
  await isarService.initialize();

  serviceLocator.registerSingleton(() => DioClient());
  serviceLocator.registerSingleton<Logger>(logger);
  
  serviceLocator.registerSingleton<AbstractFirebaseRemoteService>(FirebaseRemoteService());
  serviceLocator.registerSingleton<AuthRepository>(AuthRepoImplementation());
  serviceLocator.registerSingleton<AbstractIsarLocalService>(isarService);
  serviceLocator.registerSingleton<BiometricsRepository>(BiometricsRepoImplementation());
  serviceLocator.registerSingleton<CoinsRepository>(CoinsRepositoryImplementation(CoinsRemoteService(Dio()), _apiKey!));

  serviceLocator.registerSingleton<SignInUsecase>(SignInUsecase());
  serviceLocator.registerSingleton<SignUpUsecase>(SignUpUsecase());
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase());
  serviceLocator.registerSingleton<QuickAuthCheckUsecase>(QuickAuthCheckUsecase());
  serviceLocator.registerSingleton<QuickAuthUsecase>(QuickAuthUsecase());

}




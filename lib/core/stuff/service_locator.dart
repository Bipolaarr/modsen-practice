import 'package:get_it/get_it.dart';
import 'package:practice_app/core/net/dio_client.dart';
import 'package:practice_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:practice_app/features/auth/data/sources/firebase_remote_service.dart';
import 'package:practice_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:practice_app/features/auth/domain/usecases/signup_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {

  serviceLocator.registerSingleton(() => DioClient());
  serviceLocator.registerSingleton<FirebaseRemoteService>(FirebaseService());
  serviceLocator.registerSingleton<AuthRepository>(AuthRepoImplementation());

  serviceLocator.registerSingleton<SignInUsecase>(SignInUsecase());
  serviceLocator.registerSingleton<SignUpUsecase>(SignUpUsecase());
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase());

}




import 'package:dartz/dartz.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/core/stuff/usecase.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';

class QuickAuthUsecase extends Usecase<Either, UserModel>{

  @override
  Future<Either> call({UserModel? params}) async {
    try {
      final bool result = await serviceLocator<BiometricsRepository>().authenticateWithBiometrics();
      return Right(result);
    } catch (e) {
      return Left(e);
    }
  } 
}
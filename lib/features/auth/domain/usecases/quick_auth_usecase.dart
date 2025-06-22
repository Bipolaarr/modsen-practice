import 'package:dartz/dartz.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/core/stuff/usecase.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';

class QuickAuthUsecase extends Usecase<Either<Exception, bool>, void> {
  @override
  Future<Either<Exception, bool>> call({void params}) async {
    try {
      final result = await serviceLocator<BiometricsRepository>().authenticateWithBiometrics();
      return Right(result);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
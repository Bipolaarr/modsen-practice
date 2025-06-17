import 'package:dartz/dartz.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/core/stuff/usecase.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/domain/repositories/auth_repo.dart';

class LogoutUsecase extends Usecase<Either, UserModel>{

  @override
  Future<Either> call({UserModel ? params}) {
    return serviceLocator<AuthRepository>().logOut();
  } 

}
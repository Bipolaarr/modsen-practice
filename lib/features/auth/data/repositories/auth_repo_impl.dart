import 'package:dartz/dartz.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/data/sources/firebase_remote_service.dart';
import 'package:practice_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:practice_app/core/stuff/service_locator.dart';

class AuthRepoImplementation extends AuthRepository {

  @override
  Future<Either> signIn(UserModel req) async {
    return await serviceLocator<FirebaseRemoteService>().signIn(req);
  }

  @override
  Future<Either> signUp(UserModel req) async {
    return await serviceLocator<FirebaseRemoteService>().signUp(req);
  }
  
}
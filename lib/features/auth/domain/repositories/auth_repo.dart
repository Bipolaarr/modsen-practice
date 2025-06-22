
import 'package:dartz/dartz.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {

  Future <Either> signUp(UserModel req);
  Future <Either> signIn(UserModel req);
  Future <Either> logOut();

}
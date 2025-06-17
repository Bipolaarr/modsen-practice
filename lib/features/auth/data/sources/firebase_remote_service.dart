import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';

abstract class FirebaseRemoteService {

  Future<Either> signIn(UserModel req);
  Future<Either> signUp(UserModel req);
  Future<Either> logOut();

}

class FirebaseService extends FirebaseRemoteService {

  FirebaseService() {_auth = FirebaseAuth.instance; } 

  late FirebaseAuth _auth;

  @override
  Future<Either> signIn(UserModel req) async {
    
    try {

      await _auth.signInWithEmailAndPassword(email: req.email, password: req.password);
      return Right({'message': 'Welcome back!'});
      
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-credential':
          msg = 'Incorrect email or password. Check your input and try again';
          break;
        case 'invalid-email':
          msg = 'User with this email has not been found';
          break;
        case 'too-many-requests':
          msg = 'Too many requests. Try later';
          break;
        default:
          msg = 'An unknown error occurred';
      } 
      return Left(msg);
    }

  }


  @override
  Future<Either> signUp(UserModel req) async {

    try {
      await _auth.createUserWithEmailAndPassword(email: req.email, password: req.password);
      return Right("User has been succesfully registered");
    } on FirebaseAuthException catch (e) {

      String msg = '';
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'This email is already in use. Try to login or reset your password.';
          break; 
        case 'invalid-email':
          msg = 'This email is unavailable to use.';
          break; 
        case 'weak-password':
          msg = 'This password is too weak (should be at least 6 characters).';
          break; 
        case 'too-many-requests':
          msg = 'Too many requests. Try later.';
          break; 
        default:
          msg = 'An unknown error occurred.';
      }
      return Left(msg);
    }

  }

  @override
  Future<Either> logOut() async {
    
    try{
      await _auth.signOut();
      return Right("");
    } catch (e) {
      return Left(e);
    }

  }

}
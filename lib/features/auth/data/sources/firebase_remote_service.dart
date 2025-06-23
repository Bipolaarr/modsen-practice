import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_app/features/auth/data/models/user_model.dart';
import 'package:practice_app/features/auth/data/repositories/biometrics_repo_impl.dart';
import 'package:practice_app/features/auth/domain/repositories/biometrics_repo.dart';

abstract class AbstractFirebaseRemoteService {

  Future<Either> signIn(UserModel req);
  Future<Either> signUp(UserModel req);
  Future<Either> logOut();
  Future<Either> quickLogin();

}

class FirebaseRemoteService extends AbstractFirebaseRemoteService {

  FirebaseRemoteService() { _auth = FirebaseAuth.instance; }

  late FirebaseAuth _auth;
  final BiometricsRepository _biometricsRepository = BiometricsRepoImplementation();
  

  @override
  Future<Either> signIn(UserModel req) async {
    
    try {

      await _auth.signInWithEmailAndPassword(email: req.email, password: req.password);
      final isUserExists = await _biometricsRepository.isUserExists();
      if (!isUserExists) { await _biometricsRepository.saveUser(req); }
      
      return Right({'message': 'Welcome back!'});
      
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-credential':
          msg = 'Incorrect email or password. Check your input and try again.';
          break;
        case 'invalid-email':
          msg = 'Incorrect email or password. Check your input and try again.';
          break;
        case 'too-many-requests':
          msg = 'Servers are busy, too many requests. Come back and try again later.';
          break;
        case 'wrong-password':
          msg = 'Incorrect email or password. Check your input and try again.';
          break;
        case 'network-request-failed':
          msg = 'Network error occured. Check your connection and start again.';
          break;
        default:
          msg = e.code;
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
          msg = 'This email is unavailable to use. Check your input and try again.';
          break; 
        case 'weak-password':
          msg = 'This password is too weak (Should be at least 6 characters).';
          break; 
        case 'too-many-requests':
          msg = 'Servers are busy, too many requests. Come back and try again later.';
          break; 
        case 'network-request-failed':
          msg = 'Network error occured. Check your connection and start again.';
          break;
        default:
          msg = e.code;
      }
      return Left(msg);
    }

  }

  @override
  Future<Either> logOut() async {
    
    try{
      await _auth.signOut();
      await _biometricsRepository.deleteUser();
      print("user deleted");
      return Right("");
    } catch (e) {
      return Left(e);
    }

  }

  @override
  Future<Either> quickLogin() async {
    try {
      final user = await _biometricsRepository.getSavedUser();
      if (user == null) return Left('No saved credentials');
      
      return await signIn(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

}

import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {

  Id id = Isar.autoIncrement;

  final String email; 
  final String password;

  UserModel({
    required this.email,
    required this.password}); 

}
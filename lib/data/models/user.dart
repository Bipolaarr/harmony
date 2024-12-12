
import 'package:harmony/domain/entities/user/user.dart';

class UserModel { 

  String ? username; 
  String ? email; 
  String ? imageURL;
  String role = 'user';
  String ? uid;

  UserModel({
    this.username,
    this.email,
    this.imageURL,
    required this.role,
    this.uid
  });

  UserModel.fromJson(Map<String,dynamic> data) {

    username = data['username'];
    email = data['email'];
    imageURL = data['imageURL'];
    role = data['role'] ?? 'user';
    uid = data['uid'];
  }

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      email: email,
      imageURL: imageURL,
      role: role,
      uid: uid
    );
  }

}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      imageURL: imageURL,
      role: role,
      uid: uid
    );

  }

}
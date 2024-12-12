import 'package:harmony/domain/entities/user/user.dart';

class UserModel { 

  String ? username; 
  String ? email; 
  String ? imageURL;
  String role = 'user';
  String ? uid;
  String ? password;

  UserModel({
    this.username,
    this.email,
    this.imageURL,
    required this.role,
    this.uid,
    this.password
  });

  UserModel.fromJson(Map<String,dynamic> data) {

    username = data['username'];
    email = data['email'];
    imageURL = data['imageURL'];
    role = data['role'] ?? 'user';
    uid = data['uid'];
    password = data['password'];
  }

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      email: email,
      imageURL: imageURL,
      role: role,
      uid: uid,
      password: password
    );
  }

  // String encode(String password) =>  base64Encode(utf8.encode(password));

  // String decode(String encodedPassword) => utf8.decode(base64Decode(encodedPassword));

}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      imageURL: imageURL,
      role: role,
      uid: uid,
      password: password
    );

  }

}
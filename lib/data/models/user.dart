
import 'package:harmony/domain/entities/user/user.dart';

class UserModel { 

  String ? username; 
  String ? email; 
  String ? imageURL;
  String role = 'user';

  UserModel({
    this.username,
    this.email,
    this.imageURL,
    required this.role
  });

  UserModel.fromJson(Map<String,dynamic> data) {

    username = data['username'];
    email = data['email'];
    imageURL = data['imageURL'];
    role = 'user';
    
  }
  
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      imageURL: imageURL,
      role: role
    );

  }

}
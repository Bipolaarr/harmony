
class UserEntity { 

  String ? username; 
  String ? email;
  String ? imageURL; 
  String role;
  String ? uid;
  String ? password;
  bool isBlocked;

  UserEntity({
    this.username,
    this.email,
    this.imageURL,
    this.role = 'user',
    this.uid,
    this.password,
    this.isBlocked = false
  });
  
}
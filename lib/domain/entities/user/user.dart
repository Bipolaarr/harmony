class UserEntity { 

  String ? username; 
  String ? email;
  String ? imageURL; 
  String role;
  String ? uid;

  UserEntity({
    this.username,
    this.email,
    this.imageURL,
    this.role = 'user',
    this.uid
  });


}
class UserEntity { 

  String ? username; 
  String ? email;
  String ? imageURL; 
  String role;

  UserEntity({
    this.username,
    this.email,
    this.imageURL,
    this.role = 'user'
  });


}
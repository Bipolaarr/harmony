class CreateUserReq {

  final String username; 
  final String password; 
  final String email;

  CreateUserReq ({
    required this.username, 
    required this.email,
    required this.password
  });

}
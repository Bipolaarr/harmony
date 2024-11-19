import 'package:harmony/data/models/create_user_req.dart';

abstract class AuthRepository { 

  Future <void> signup(CreateUserReq request); 

  Future <void> signin();

}
import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';

abstract class AuthRepository { 

  Future <Either> signup(CreateUserReq request); 

  Future <Either> signin(SigninUserReq request);

  Future <Either> getUser();

}
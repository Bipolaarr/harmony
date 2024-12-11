import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/data/models/update_user_req.dart';
import 'package:harmony/domain/entities/user/user.dart';

abstract class AuthRepository { 

  Future <Either> signup(CreateUserReq request); 

  Future <Either> signin(SigninUserReq request);

  Future <Either> getUser();

  Future<Either<String, String>> updateUser(UpdateUserReq request);

   Future<Either<String, List<UserEntity>>> getAllUsers();

}
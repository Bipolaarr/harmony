import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/data/sources/auth_firebase_service.dart';
import 'package:harmony/domain/repositories/auth.dart';
import 'package:harmony/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {

  @override
  Future<Either> signin(SigninUserReq request) async {
      return await serviceLocator<AuthFirebaseService>().signin(request);
  }

  @override
  Future<Either> signup(CreateUserReq request) async {
    
    return await serviceLocator<AuthFirebaseService>().signup(request);

  }




}
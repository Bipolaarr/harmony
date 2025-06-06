import 'package:dartz/dartz.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/data/models/update_user_req.dart';
import 'package:harmony/data/sources/auth_fb_service.dart';
import 'package:harmony/domain/entities/user/user.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
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
  
  @override
  Future<Either> getUser() async {
    return await serviceLocator<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either<String, String>> updateUser(UpdateUserReq request) async {
    return await serviceLocator<AuthFirebaseService>().updateUser(request);
  }

  Future<Either<String, List<UserEntity>>> getAllUsers() async {
     return await serviceLocator<AuthFirebaseService>().getAllUsers();
  }

  //----
  
  @override
  Future<Either<String, void>> deleteUser(String userId) async  {
    return await serviceLocator<AuthFirebaseService>().deleteUser(userId);
  }
  
  @override
  Future<Either<String, String>> blockUser(UserEntity user) async{
    return await serviceLocator<AuthFirebaseService>().blockUser(user);
  }

}
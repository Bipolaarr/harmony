import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
import 'package:harmony/service_locator.dart';

class SignupUseCase implements Usecase<Either,CreateUserReq> {
  
  @override
  Future<Either> call({CreateUserReq ? params}) {
    return serviceLocator<AuthRepository>().signup(params!);
  } 


}
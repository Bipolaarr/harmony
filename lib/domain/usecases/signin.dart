import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/domain/repositories/auth.dart';
import 'package:harmony/service_locator.dart';

class SigninUseCase implements Usecase<Either,SigninUserReq> {
  
  @override
  Future<Either> call({SigninUserReq ? params}) {
    return serviceLocator<AuthRepository>().signin(params!);
  } 

}
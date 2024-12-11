import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/data/models/update_user_req.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
import 'package:harmony/service_locator.dart';

class UpdateUserUseCase implements Usecase<Either<String, String>, UpdateUserReq> {
  
  @override
  Future<Either<String, String>> call({UpdateUserReq? params}) async {
    if (params == null) {
      return Left('Parameters cannot be null');
    }
    return await serviceLocator<AuthRepository>().updateUser(params);
  }
}
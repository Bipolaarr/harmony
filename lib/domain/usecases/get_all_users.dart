import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
import 'package:harmony/service_locator.dart';

class GetAllUsersUseCase implements Usecase<Either,dynamic> {
  
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<AuthRepository>().getAllUsers();
  } 

}
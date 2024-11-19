import 'package:firebase_core/firebase_core.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/sources/auth_firebase_service.dart';
import 'package:harmony/domain/repositories/auth.dart';
import 'package:harmony/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {

  @override
  Future<void> signin() {
  
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq request) async {
    await serviceLocator<AuthFirebaseService>().signup(request);

    throw UnimplementedError();
  }




}
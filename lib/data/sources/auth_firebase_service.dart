import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/data/models/create_user_req.dart';

abstract class AuthFirebaseService {

  Future<void> signin();

  Future<void> signup(CreateUserReq request); 

}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {

  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup(CreateUserReq request) async {
    
    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,   
      );

    } on FirebaseAuthException catch (e) { }

  }

}
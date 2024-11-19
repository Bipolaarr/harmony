import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {

  Future<void> signin();

  Future<void> signup(); 

}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {

  @override
  Future<void> signin() {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signup() async {
    
    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password)

     } on FirebaseAuthException catch (e) {

     }

  }

}
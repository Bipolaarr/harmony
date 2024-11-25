import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';

abstract class AuthFirebaseService {

  Future<Either> signin(SigninUserReq request);

  Future<Either> signup(CreateUserReq request); 

}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {

  @override
  Future<Either> signin(SigninUserReq request) async{
    
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,   
        
      );

      return Right('Welcome back!');

    } on FirebaseAuthException catch (e) {

        String msg = ''; 

        switch(e.code) {
          case 'invalid-credential':
            msg = 'Wrong password provided for this user';
          case 'invalid-email':
            msg = 'User with this email has not been found';
            case 'too-many-requests':
            msg = 'To many requests. Try later'; 
        }

        return Left(msg); 


     }


  }

  @override
  Future<Either> signup(CreateUserReq request) async {
    
    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,   
      );

      return Right('Account have been successfully created');

    } on FirebaseAuthException catch (e) {

        String msg = ''; 

        switch(e.code) {
          case 'email-already-in-use':
            msg = 'This email is already in use. Try to login or reset your password';
          case 'invalid-email':
            msg = 'This email is unavailable to use';
          case 'weak-password':
            msg = 'This Password is too weak (should be at least 8 characters)';
          case 'too-many-requests':
            msg = 'To many requests. Try later'; 
        }

        return Left(msg); 


     }

      
  }

}
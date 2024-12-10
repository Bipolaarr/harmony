import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signin(SigninUserReq request);
  Future<Either<String, String>> signup(CreateUserReq request);
  Future<Either<String, String>> getCurrentUsername();
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signin(SigninUserReq request) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return const Right('Welcome back!');
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-credential':
          msg = 'Wrong password provided for this user';
          break; // Added break statement
        case 'invalid-email':
          msg = 'User with this email has not been found';
          break; // Added break statement
        case 'too-many-requests':
          msg = 'Too many requests. Try later';
          break; // Added break statement
        default:
          msg = 'An unknown error occurred';
      }
      return Left(msg);
    }
  }

  @override
  Future<Either<String, String>> signup(CreateUserReq request) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      await FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'username': request.username,
        'email': data.user?.email,
        'password': request.password, // Consider removing this for security reasons
      });

      return const Right('Account has been successfully created');
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'This email is already in use. Try to login or reset your password';
          break; // Added break statement
        case 'invalid-email':
          msg = 'This email is unavailable to use';
          break; // Added break statement
        case 'weak-password':
          msg = 'This password is too weak (should be at least 8 characters)';
          break; // Added break statement
        case 'too-many-requests':
          msg = 'Too many requests. Try later';
          break; // Added break statement
        default:
          msg = 'An unknown error occurred';
      }
      return Left(msg);
    }
  }

  @override
  Future<Either<String, String>> getCurrentUsername() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return Left('No user is currently signed in.');
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('username')) {
          String username = data['username'];
          return Right(username);
        } else {
          return Left('Username field does not exist.');
        }
      } else {
        return Left('User document does not exist.');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }
  
}
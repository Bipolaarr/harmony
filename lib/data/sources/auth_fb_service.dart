import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/data/models/create_user_req.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/data/models/update_user_req.dart';
import 'package:harmony/data/models/user.dart';
import 'package:harmony/domain/entities/user/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SigninUserReq request);
  Future<Either> signup(CreateUserReq request);
  Future<Either> getUser();
  Future<Either<String, String>> updateUser(UpdateUserReq request);
}

class AuthFirebaseServiceImplementation extends AuthFirebaseService {

  @override
  Future<Either<String, Map<String, String>>> signin(SigninUserReq request) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      // Fetch user role from Firestore
      var userDoc = await FirebaseFirestore.instance.collection('Users').doc(userCredential.user?.uid).get();
      
      if (!userDoc.exists) {
        return Left('User not found');
      }

      // Return a map with the welcome message and the user's role
      String role = userDoc['role']; // Default to 'user' if role is not found
      return Right({'message': 'Welcome back!', 'role': role});
      
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'invalid-credential':
          msg = 'Wrong password provided for this user';
          break;
        case 'invalid-email':
          msg = 'User with this email has not been found';
          break;
        case 'too-many-requests':
          msg = 'Too many requests. Try later';
          break;
        default:
          msg = 'An unknown error occurred';
      }
      return Left(msg);
    }
  }

  @override
  Future<Either> signup(CreateUserReq request) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      // Set user data in Firestore including the role
      await FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'username': request.username,
        'email': data.user?.email,
        'role': 'user', // Assign role automatically
        // Optionally, you can add other fields like imageURL here
      });

      return const Right('Account has been successfully created');
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'This email is already in use. Try to login or reset your password.';
          break; 
        case 'invalid-email':
          msg = 'This email is unavailable to use.';
          break; 
        case 'weak-password':
          msg = 'This password is too weak (should be at least 8 characters).';
          break; 
        case 'too-many-requests':
          msg = 'Too many requests. Try later.';
          break; 
        default:
          msg = 'An unknown error occurred.';
      }
      return Left(msg);
    }
  }
  
  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? uid = firebaseAuth.currentUser?.uid;

      if (uid == null) {
        return const Left('No user is currently signed in');
      }

      var userDoc = await firebaseFirestore.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        return const Left('User not found');
      }

      UserModel userModel = UserModel.fromJson(userDoc.data()!);
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppImages.defaultImage;

      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } on Exception catch (e) {
      return Left('An error occurred: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, String>> updateUser(UpdateUserReq request) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? uid = firebaseAuth.currentUser?.uid;

      if (uid == null) {
        return const Left('No user is currently signed in');
      }

      // Reauthenticate the user with current password
      if (request.currentPassword != null) {
        User? user = firebaseAuth.currentUser;
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: request.currentPassword!,
        );

        await user.reauthenticateWithCredential(credential);
      }

      
      Map<String, dynamic> updates = {};
      if (request.username != null) {
        updates['username'] = request.username;
      }
      if (request.email != null) {
        updates['email'] = request.email;
        // ignore: deprecated_member_use
        await firebaseAuth.currentUser?.updateEmail(request.email!);
      }
      if (request.newPassword != null) {
        updates['password'] = request.newPassword;
        await firebaseAuth.currentUser?.updatePassword(request.newPassword!);
      }

      await firebaseFirestore.collection('Users').doc(uid).update(updates);

      return const Right('User data has been successfully updated');
    } on FirebaseAuthException catch (e) {
      String msg = '';
      switch (e.code) {
        case 'requires-recent-login':
          msg = 'Please log in again to perform this action';
          break;
        case 'invalid-email':
          msg = 'Invalid email address';
          break;
        case 'email-already-in-use':
          msg = 'This email is already in use';
          break;
        case 'weak-password':
          msg = 'The new password is too weak';
          break;
        default:
          msg = 'An unknown error occurred';
      }
      return Left(msg);
    } catch (e) {
      return Left('An error occurred: ${e.toString()}');
    }
  }
}

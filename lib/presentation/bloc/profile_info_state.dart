import 'package:harmony/domain/entities/user/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {

  final UserEntity userEntity;
  ProfileInfoLoaded({required this.userEntity});
  
}

class ProfileInfoLoadindFailed extends ProfileInfoState {}
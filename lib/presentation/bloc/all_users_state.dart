import 'package:harmony/domain/entities/user/user.dart';

abstract class AllUsersState {}

class AllUsersLoading extends AllUsersState {}

class AllUsersLoadingFailed extends AllUsersState {}

class AllUsersLoaded extends AllUsersState {
  final List<UserEntity> allUsers;

  AllUsersLoaded({required this.allUsers});
}
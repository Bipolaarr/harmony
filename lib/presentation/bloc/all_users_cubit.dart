
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/user/user.dart';
import 'package:harmony/domain/usecases/block_user.dart';
import 'package:harmony/domain/usecases/delete_user.dart';
import 'package:harmony/domain/usecases/get_all_users.dart';
import 'package:harmony/presentation/bloc/all_users_state.dart';
import 'package:harmony/service_locator.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  AllUsersCubit() : super(AllUsersLoading());
  
  
  List<UserEntity> usersList = [];

  Future<void> getAllUsers() async {
    
    var result  = await serviceLocator<GetAllUsersUseCase>().call();
    
    result.fold(
      (l){
        emit(
          AllUsersLoadingFailed()
        );
      },
      (data){

        usersList = data;
        emit(
          AllUsersLoaded(allUsers: usersList)
        );
      }
    );
  }

  Future<void> deleteUser(String userId) async {

    // Call the delete user use case
    var result = await serviceLocator<DeleteUserUseCase>().call(params: userId);

    result.fold(
      (errorMessage) {
        emit(AllUsersLoadingFailed()); // Emit failure state on error
      },
      (_) {
        // Remove the user from the local list
        usersList.removeWhere((user) => user.uid == userId);
        emit(AllUsersLoaded(allUsers: usersList)); // Emit updated user list
      },
    );
  }

  Future<void> blockUser(UserEntity user) async {
    // Call the Firestore method to update the blocked status
    var result = await serviceLocator<BlockUserUseCase>().call(params: user);

    result.fold(
      (errorMessage) {
        emit(AllUsersLoadingFailed()); // Emit failure state on error
      },
      (_) {
        // Update the local usersList to reflect the new blocked status
        user.isBlocked = !user.isBlocked; // Toggle the local blocked status
        emit(AllUsersLoaded(allUsers: usersList)); // Emit updated user list
      },
    );
  }
}
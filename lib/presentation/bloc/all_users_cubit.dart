
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/user/user.dart';
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

}
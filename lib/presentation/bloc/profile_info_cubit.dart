import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/usecases/get_user.dart';
import 'package:harmony/presentation/bloc/profile_info_state.dart';
import 'package:harmony/service_locator.dart';


class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    // Call the GetUserUseCase
    final result = await serviceLocator<GetUserUseCase>().call();

    // Use fold to handle the Either result
    result.fold(
      (failure) {
        emit(ProfileInfoLoadindFailed()); // Handle failure case
      },
      (userEntity) {
        emit(ProfileInfoLoaded(userEntity: userEntity)); // Emit loaded state with userEntity
      },
    );
  }
}
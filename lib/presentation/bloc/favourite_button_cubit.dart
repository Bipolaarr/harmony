import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/usecases/add_or_remove_favourite.dart';
import 'package:harmony/presentation/bloc/favourite_button_state.dart';
import 'package:harmony/service_locator.dart';


class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {

  FavouriteButtonCubit() : super(FavouriteButtonInitial());

  Future<void> favouriteButtonUpdated(String songId) async {
    
    var result = await serviceLocator<AddOrRemoveFavouriteUseCase>().call(
      params: songId
    );
    result.fold(
      (l){},
      (isFavorite){
        emit(
          FavouriteButtonUpdated(
            isFavourite: isFavorite
          )
        );
      },
    );
  }
}
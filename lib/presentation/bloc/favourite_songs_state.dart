import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/usecases/get_user_favourites.dart';
import 'package:harmony/presentation/bloc/favourite_songs_cubit.dart';
import 'package:harmony/service_locator.dart';

class FavouriteSongsCubit extends Cubit<FavouriteSongsState> {
  FavouriteSongsCubit() : super(FavouriteSongsLoading());
  
  
  List<SongEntity> favouriteSongs = [];

  Future<void> getFavoriteSongs() async {
   
   var result  = await serviceLocator<GetUserFavouriteSongsUseCase>().call();
   
   result.fold(
    (l){
      emit(
        FavouriteSongsLoadingFailed()
      );
    },
    (r){
      favouriteSongs = r;
      emit(
        FavouriteSongsLoaded(favouriteSongs: favouriteSongs)
      );
    }
  );
}

 void removeSong(int index) {
   favouriteSongs.removeAt(index);
   emit(
     FavouriteSongsLoaded(favouriteSongs: favouriteSongs)
   );
 }

}
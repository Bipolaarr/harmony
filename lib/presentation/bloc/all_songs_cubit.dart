

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/usecases/get_all_songs.dart';
import 'package:harmony/presentation/bloc/all_songs_state.dart';
import 'package:harmony/service_locator.dart';

class AllSongsCubit extends Cubit<AllSongsState> {
   AllSongsCubit() : super(AllSongsLoading());
  
  
  List<SongEntity> songsList = [];

  Future<void> getAllSongs() async {
   
   var result  = await serviceLocator<GetAllSongsUseCase>().call();
   
   result.fold(
    (l){
      emit(
        AllSongsLoadingFailed()
      );
    },
    (data){

      songsList = data;
      emit(
        AllSongsLoaded(allSongs: songsList)
      );
    }
  );
}

 void removeSong(int index) {
   songsList.removeAt(index);
   emit(
     AllSongsLoaded(allSongs: songsList)
   );
 }

}
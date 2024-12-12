

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/usecases/delete_song.dart';
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

 Future<void> deleteSong(String songId) async {
  // Call the delete song use case
  var result = await serviceLocator<DeleteSongUseCase>().call(params: songId);

  result.fold(
    (errorMessage) {
      emit(AllSongsLoadingFailed()); // Emit failure state on error
    },
    (_) {
      // Remove the song from the local list
      songsList.removeWhere((song) => song.songId == songId); // Ensure you're checking by songId

      emit(AllSongsLoaded(allSongs: songsList)); // Emit updated song list
    },
  );
}

}
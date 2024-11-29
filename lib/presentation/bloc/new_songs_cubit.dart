import 'package:harmony/domain/usecases/get_new_songs.dart';
import 'package:harmony/presentation/bloc/new_songs_state.dart';
import 'package:harmony/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class NewSongsCubit extends Cubit<NewSongsState> {

    NewSongsCubit() : super(NewSongsLoading()); 

  Future<void> getNewSongs() async {

    var returnedSongs = await serviceLocator<GetNewSongsUseCase>().call();

    returnedSongs.fold(
      (l) { 
        emit(NewSongsLoadingFailed()); 
      }, 
      (data) { 
        emit(NewSongsLoaded(songs:data)); 
      }

    );

  }

}
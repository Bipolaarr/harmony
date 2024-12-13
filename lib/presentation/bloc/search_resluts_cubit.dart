import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/usecases/search_usecase.dart';
import 'package:harmony/presentation/bloc/search_results_state.dart';
import 'package:harmony/service_locator.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  SearchResultsCubit() : super(SearchResultsLoading());
  
  
  List<SongEntity> foundSongs = [];

  Future<void> searchSongs() async {
   
   var result  = await serviceLocator<SearchUseCase>().call();
   
   result.fold(
    (l){
      emit(
        SearchResultsLoadingFailed()
      );
    },
    (r){
      foundSongs = r;
      emit(
        SearchResultsLoaded(foundSongs: foundSongs)
      );
    }
  );
}

}
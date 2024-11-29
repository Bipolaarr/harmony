import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/usecases/get_all_artists.dart';
import 'package:harmony/presentation/bloc/all_artists_state.dart';
import 'package:harmony/service_locator.dart';

class AllArtistsCubit extends Cubit<AllArtistsState> {

  AllArtistsCubit() : super(AllArtistsLoading()); 

  Future<void> getAllArtists() async {
    var returnedArtists = await serviceLocator<GetAllArtistsUseCase>().call();

    returnedArtists.fold(
      (error) {
        emit(AllArtistLoadingFailed()); 
      },
      (data) {
        emit(AllArtistsLoaded(artists: data)); 
      },
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/domain/usecases/get_all_genres.dart';
import 'package:harmony/presentation/bloc/all_genres_state.dart';
import 'package:harmony/service_locator.dart';

class AllGenresCubit extends Cubit<AllGenresState> {

  AllGenresCubit() : super(AllGenresLoading()); 

  Future<void> getAllGenres() async {
    var returnedGenres = await serviceLocator<GetAllGenresUseCase>().call();

    returnedGenres.fold(
      (error) {
        emit(AllGenresLoadingFailed()); 
      },
      (data) {
        emit(AllGenresLoaded(genres: data)); 
      },
    );
  }
}
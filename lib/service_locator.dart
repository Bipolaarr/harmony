import 'package:get_it/get_it.dart';
import 'package:harmony/data/repoimpls/artists_repostiory_implementations.dart';
import 'package:harmony/data/repoimpls/auth_repository_implementation.dart';
import 'package:harmony/data/repoimpls/genres_repository_implementration.dart';
import 'package:harmony/data/repoimpls/songs_repository_implementation.dart';
import 'package:harmony/data/sources/artists_firebase_service.dart';
import 'package:harmony/data/sources/auth_fb_service.dart';
import 'package:harmony/data/sources/genres_fb_service.dart';
import 'package:harmony/data/sources/songs_fb_service.dart';
import 'package:harmony/domain/repositories/artist/artist.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
import 'package:harmony/domain/repositories/genre/genre.dart';
import 'package:harmony/domain/repositories/song/song.dart';
import 'package:harmony/domain/usecases/add_or_remove_favourite.dart';
import 'package:harmony/domain/usecases/create_top_picks_block.dart';
import 'package:harmony/domain/usecases/get_all_artists.dart';
import 'package:harmony/domain/usecases/get_all_genres.dart';
import 'package:harmony/domain/usecases/get_new_songs.dart';
import 'package:harmony/domain/usecases/get_songs_by_artist.dart';
import 'package:harmony/domain/usecases/get_songs_by_genre.dart';
import 'package:harmony/domain/usecases/get_user.dart';
import 'package:harmony/domain/usecases/get_user_favourites.dart';
import 'package:harmony/domain/usecases/is_favourite.dart';
import 'package:harmony/domain/usecases/signin.dart';
import 'package:harmony/domain/usecases/signup.dart';

final serviceLocator = GetIt.instance; 

Future<void> initDependencies() async { 

  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<SongsFirebaseService>(
    SongsFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<ArtistsFirebaseService>(
    ArtistsFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<GenresFirebaseService>(
   GenresFirebaseServiceImplementation()
  );




  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation() 
  );

  serviceLocator.registerSingleton<SongsRepository>(
    SongsRepositoryImplementation()
  );

  serviceLocator.registerSingleton<ArtistsRepository>(
    ArtistsRepostioryImplementation()
  );

  serviceLocator.registerSingleton<GenresRepository>(
    GenresRepositoryImplementration()
  );



  serviceLocator.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );  

  serviceLocator.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );   

  serviceLocator.registerSingleton<GetNewSongsUseCase>(
    GetNewSongsUseCase()
  ); 

  serviceLocator.registerSingleton<GetAllArtistsUseCase>(
    GetAllArtistsUseCase()
  );        

  serviceLocator.registerSingleton<GetAllGenresUseCase>(
    GetAllGenresUseCase()
  ); 

  serviceLocator.registerSingleton<CreateTopPicksBlock>(
    CreateTopPicksBlock()
  ); 

  serviceLocator.registerSingleton<GetSongsByGenre>(
    GetSongsByGenre()
  ); 

  serviceLocator.registerSingleton<GetSongsByArtist>(
    GetSongsByArtist()
  ); 

  serviceLocator.registerSingleton<AddOrRemoveFavouriteUseCase>(
    AddOrRemoveFavouriteUseCase()
  ); 

  serviceLocator.registerSingleton<IsFavouriteUseCase>(
    IsFavouriteUseCase()
  );

  serviceLocator.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
  );

  serviceLocator.registerSingleton<GetUserFavouriteSongsUseCase>(
    GetUserFavouriteSongsUseCase()
  );
}
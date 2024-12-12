// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:harmony/data/sources/songs_fb_service.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/domain/repositories/song/song.dart';
import 'package:harmony/service_locator.dart';

class SongsRepositoryImplementation extends SongsRepository{
  @override
  Future<Either> getNewSongs() async {
    
    return await serviceLocator<SongsFirebaseService>().getNewSongs();

  }
  
  @override
  Future<Either> createTopPicksBlock() async {
   
    return await serviceLocator<SongsFirebaseService>().createTopPicksBlock();

  }

  @override
  Future<Either> getSongsByArtist(String artist) async {
   
    return await serviceLocator<SongsFirebaseService>().getSongsByArtist(artist);

  }

  @override
  Future<Either> getSongsByGenre(String genre) async {
   
    return await serviceLocator<SongsFirebaseService>().getSongsByGenre(genre);

  }
  
  @override
  Future<Either> addOrRemoveFavourites(String SongId) async {

    return await serviceLocator<SongsFirebaseService>().addOrRemoveFavourites(SongId);

  }
  
  @override
  Future<bool> isFavourite(String SongId) async {

    return await serviceLocator<SongsFirebaseService>().isFavourite(SongId);

  }
  
  @override
  Future<Either> getUserFavouriteSongs() async {

    return await serviceLocator<SongsFirebaseService>().getUserFavouriteSongs();

  }

  @override
  Future<Either> getAllSongs() async {

    return await serviceLocator<SongsFirebaseService>().getAllSongs();

  }
  
  @override
  Future<Either<String, List<SongEntity>>> searchSongs(String query) async {
    return await serviceLocator<SongsFirebaseService>().searchSongs(query);
  }
  
  @override
  Future<Either<String, void>> deleteSong(String songId) async  {
    return await serviceLocator<SongsFirebaseService>().deleteSong(songId);
  }



}
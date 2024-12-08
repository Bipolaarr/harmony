import 'package:dartz/dartz.dart';
import 'package:harmony/data/sources/songs_fb_service.dart';
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

  Future<Either> getSongsByArtist(String artist) async {
   
    return await serviceLocator<SongsFirebaseService>().getSongsByArtist(artist);

  }

  Future<Either> getSongsByGenre(String genre) async {
   
    return await serviceLocator<SongsFirebaseService>().getSongsByGenre(genre);

  }


  



}
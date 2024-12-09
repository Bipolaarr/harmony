import 'package:dartz/dartz.dart';

abstract class SongsRepository { 

  Future <Either> getNewSongs();

  Future <Either> createTopPicksBlock();

  Future <Either> getSongsByArtist(String artist);

  Future <Either> getSongsByGenre(String genre);

  Future <Either> addOrRemoveFavourites(String SongId);

  Future <bool> isFavourite(String SongId);

}
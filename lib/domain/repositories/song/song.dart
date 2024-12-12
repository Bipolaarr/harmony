// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:harmony/domain/entities/song/song.dart';

abstract class SongsRepository { 

  Future <Either> getNewSongs();

  Future <Either> createTopPicksBlock();

  Future <Either> getSongsByArtist(String artist);

  Future <Either> getSongsByGenre(String genre);

  Future <Either> addOrRemoveFavourites(String SongId);

  Future <bool> isFavourite(String SongId);

  Future <Either> getUserFavouriteSongs();

  Future <Either> getAllSongs();

  Future<Either<String, void>> deleteSong(String songId);

  // Future <void> addSong();

  Future<Either<String, List<SongEntity>>> searchSongs(String query);

}
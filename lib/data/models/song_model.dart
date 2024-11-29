import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/domain/entities/song/song.dart';

class SongModel { 

  String ? title;
  String ? artist;
  String ? genre;
  num ? duration; 
  Timestamp ? releaseDate; 
  String ? album;

  SongModel ({
    required this.title,
    required this.artist,
    required this.genre,
    required this.duration,
    required this.releaseDate,
    required this.album
  });

  SongModel.fromJson(Map<String,dynamic> data) {

    title = data['title'];
    artist = data['artist'];
    genre = data['genre'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    album = data['album'];

  }

}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!, 
      genre: genre!, 
      duration: duration!, 
      releaseDate: releaseDate!,
      album: album!
      );
  }
}
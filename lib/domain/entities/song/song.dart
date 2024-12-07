import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/core/configs/Constansts/app_urls.dart';

class SongEntity { 

  final String title;
  final String artist;
  final String genre;
  final num duration; 
  final Timestamp releaseDate; 
  final String album;

  SongEntity ({
    required this.title,
    required this.artist,
    required this.genre,
    required this.duration,
    required this.releaseDate, 
    required this.album
  });

  @override
  String toString() {
    return 'SongEntity(title: $title, artist: $artist, genre: $genre, duration: $duration, releaseDate: $releaseDate, album: $album)';
  }  

  String get url {
    return '${AppUrls.firestorageSongs}${Uri.encodeComponent('$artist - $title.mp3')}?${AppUrls.mediaAlt}';
  }

}
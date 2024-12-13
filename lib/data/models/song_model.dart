import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmony/domain/entities/song/song.dart';

class SongModel {
  String title; // Made non-nullable
  String artist; // Made non-nullable
  String? genre; // Nullable
  num? duration; // Nullable
  Timestamp? releaseDate; // Nullable
  String? album; // Nullable
  bool isFavourite; // Made non-nullable
  String songId; // Made non-nullable

  SongModel({
    required this.title,
    required this.artist,
    this.genre,
    this.duration,
    this.releaseDate,
    this.album,
    required this.isFavourite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> data)
      : title = data['title'] ?? '', // Default to empty string if null
        artist = data['artist'] ?? '', // Default to empty string if null
        genre = data['genre'],
        duration = data['duration'],
        releaseDate = data['releaseDate'],
        album = data['album'],
        isFavourite = data['isFavourite'] ?? false, // Default to false if null
        songId = data['songId'] ?? ''; // Default to empty string if null
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      genre: genre!,
      duration: duration!,
      releaseDate: releaseDate!,
      album: album!,
      isFavourite: isFavourite,
      songId: songId,
    );
  }
}
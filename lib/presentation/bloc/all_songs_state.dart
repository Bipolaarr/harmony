import 'package:harmony/domain/entities/song/song.dart';

abstract class AllSongsState {}

class AllSongsLoading extends AllSongsState {}

class AllSongsLoadingFailed extends AllSongsState {}

class AllSongsLoaded extends AllSongsState {

  final List<SongEntity> allSongs;

  AllSongsLoaded({required this.allSongs});

}
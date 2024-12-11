import 'package:harmony/domain/entities/song/song.dart';

abstract class FavouriteSongsState {}

class FavouriteSongsLoading extends FavouriteSongsState{}

class FavouriteSongsLoaded extends FavouriteSongsState {

  final List<SongEntity> favouriteSongs;

 FavouriteSongsLoaded({required this.favouriteSongs});

}

class FavouriteSongsLoadingFailed extends FavouriteSongsState {}
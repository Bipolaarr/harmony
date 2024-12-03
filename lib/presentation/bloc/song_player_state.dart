// song_player_state.dart

abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoadingFailed extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final double volume; // Include volume in the loaded state

  SongPlayerLoaded({required this.volume});
}
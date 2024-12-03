import 'package:harmony/presentation/bloc/song_player_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      autoPlayWhenOpenedSong();
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerLoadingFailed());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  void autoPlayWhenOpenedSong() {
    audioPlayer.play();
    emit(SongPlayerLoaded());
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
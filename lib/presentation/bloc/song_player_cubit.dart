import 'dart:math';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/song_player_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  double volume = 1.0;
  bool isShuffled = false; 
  bool isRepeated = false; 

  List<SongEntity> playlist = [];
  List<SongEntity> get songsList => playlist;

  int currentSongIndex = 0; 
  int previousSongIndex = -1; // Для хранения предыдущего индекса
  bool isClosing = false; 

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });

    // Слушатель завершения трека
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _handleTrackCompletion();
      }
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded(volume: volume));
  }

  Future<void> loadPlaylist(List<SongEntity> songs, int index) async {
    playlist = songs;
    currentSongIndex = index; 
    await loadSong(playlist[currentSongIndex].url);
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      autoPlayWhenOpenedSong();
      emit(SongPlayerLoaded(volume: volume));
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
    emit(SongPlayerLoaded(volume: volume));
  }

  void autoPlayWhenOpenedSong() {
    audioPlayer.play();
    emit(SongPlayerLoaded(volume: volume));
  }

  void nextSong() {
    if (isRepeated) {
      // Если активен повтор, начинаем текущую песню заново
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    } else if (isShuffled) {
      // Если активен шаффл, выбираем случайную песню, избегая повторения
      int newIndex;
      do {
        newIndex = (playlist.length * Random().nextDouble()).toInt();
      } while (newIndex == previousSongIndex); // Проверяем, что индекс не совпадает с предыдущим

      previousSongIndex = newIndex; // Обновляем предыдущий индекс
      currentSongIndex = newIndex; // Устанавливаем новый индекс
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    } else {
      // Обычная логика перехода к следующей песне
      if (currentSongIndex < playlist.length - 1) {
        currentSongIndex++;
      } else {
        currentSongIndex = 0; // Возвращаемся к первой песне, если дошли до конца
      }
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    }
  }

  void previousSong() {
    if (isRepeated && currentSongIndex == 0) {
      // Если мы в режиме повтора, просто повторяем текущую песню
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    } else {
      // Обычная логика перехода к предыдущей песне
      if (currentSongIndex > 0) {
        currentSongIndex--;
      } else {
        currentSongIndex = playlist.length - 1; // Переходим к последней песне
      }
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    }
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  void setVolume(double newVolume) {
    volume = newVolume;
    audioPlayer.setVolume(volume);
    emit(SongPlayerLoaded(volume: volume));
  }

  void _handleTrackCompletion() {
    if (isRepeated) {
      // Если активен повтор, начинаем текущую песню заново
      loadSong(playlist[currentSongIndex].url).then((_) {
        emit(SongPlayerLoaded(volume: volume));
      });
    } else {
      // Если не активен повтор, переходим к следующей песне
      nextSong();
    }
  }

  @override
  Future<void> close() async {
    isClosing = true; 
    await audioPlayer.stop(); 
    await audioPlayer.dispose(); 
    return super.close();
  }
}
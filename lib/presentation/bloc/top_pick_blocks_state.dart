
import 'package:harmony/domain/entities/song/song.dart';

abstract class TopPickBlocksState {}

class TopPicksBlockLoading extends TopPickBlocksState {}

class TopPicksBlockLoaded extends TopPickBlocksState {

  final List<SongEntity> pickedSongs;

  TopPicksBlockLoaded({required this.pickedSongs});

}

class TopPicksBlockFailed extends TopPickBlocksState {}
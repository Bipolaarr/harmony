import 'package:harmony/domain/entities/song/song.dart';

abstract class SearchResultsState {}

class SearchResultsLoading extends SearchResultsState{}

class SearchResultsLoaded extends SearchResultsState {

  final List<SongEntity> foundSongs;

 SearchResultsLoaded({required this.foundSongs});

}

class SearchResultsLoadingFailed extends SearchResultsState {}
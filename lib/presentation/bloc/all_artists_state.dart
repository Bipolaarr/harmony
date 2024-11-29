import 'package:harmony/domain/entities/artist/artist.dart';

abstract class AllArtistsState {}

class AllArtistsLoading extends AllArtistsState{}

class AllArtistsLoaded extends AllArtistsState {

  final List<ArtistEntity> artists;

  AllArtistsLoaded({required this.artists});

}

class AllArtistLoadingFailed extends AllArtistsState {}
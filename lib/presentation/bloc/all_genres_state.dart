
import 'package:harmony/domain/entities/genre/genre.dart';

abstract class AllGenresState {}

class AllGenresLoading extends AllGenresState{}

class AllGenresLoaded extends AllGenresState {

  final List<GenreEntity> genres;

  AllGenresLoaded({required this.genres});

}

class AllGenresLoadingFailed extends AllGenresState {}
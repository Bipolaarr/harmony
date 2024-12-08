import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/data/sources/songs_fb_service.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/service_locator.dart';

class GetSongsByArtist implements Usecase<Either<String, List<SongEntity>>, String> {
  @override
  Future<Either<String, List<SongEntity>>> call({String? params}) async {
    if (params == null) {
      return Left('Genre parameter is required');
    }
    return await serviceLocator<SongsFirebaseService>().getSongsByArtist(params);
  }
}
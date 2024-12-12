import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/domain/repositories/song/song.dart';

import 'package:harmony/service_locator.dart';

class DeleteSongUseCase implements Usecase<Either<String, void>, String> {
  @override
  Future<Either<String, void>> call({String? params}) async {
    if (params == null) {
      return Left('User ID cannot be null');
    }
    
    try {
      await serviceLocator<SongsRepository>().deleteSong(params);
      return const Right(null); // Success
    } catch (e) {
      return Left('Failed to delete user: ${e.toString()}');
    }
  }
}
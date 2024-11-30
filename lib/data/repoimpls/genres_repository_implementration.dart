import 'package:dartz/dartz.dart';
import 'package:harmony/data/sources/genres_fb_service.dart';
import 'package:harmony/domain/repositories/genre/genre.dart';

import 'package:harmony/service_locator.dart';

class GenresRepositoryImplementration extends GenresRepository{
  
  @override
  Future<Either> getAllGenres() async {
    
    return await serviceLocator<GenresFirebaseService>().getAllGenres();

  }
  
}
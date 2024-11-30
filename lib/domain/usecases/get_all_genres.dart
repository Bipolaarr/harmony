import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/domain/repositories/genre/genre.dart';

import 'package:harmony/service_locator.dart';

class GetAllGenresUseCase implements Usecase<Either,dynamic> {
  
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<GenresRepository>().getAllGenres();
  } 

}
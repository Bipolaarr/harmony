import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';

import 'package:harmony/domain/repositories/song/song.dart';

import 'package:harmony/service_locator.dart';

class AddOrRemoveFavouriteUseCase implements Usecase<Either,String> {
  
  @override
  Future<Either> call({String ? params}) async {
    return await serviceLocator<SongsRepository>().addOrRemoveFavourites(params!);
  } 

}
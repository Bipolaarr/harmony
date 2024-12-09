
import 'package:harmony/core/usecase/usecase.dart';

import 'package:harmony/domain/repositories/song/song.dart';

import 'package:harmony/service_locator.dart';

class IsFavouriteUseCase implements Usecase<bool,String> {
  
  @override
  Future<bool> call({String ? params}) async {
    return await serviceLocator<SongsRepository>().isFavourite(params!);
  } 

}
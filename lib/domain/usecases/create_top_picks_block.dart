import 'package:dartz/dartz.dart';
import 'package:harmony/core/usecase/usecase.dart';
import 'package:harmony/domain/repositories/song/song.dart';

import 'package:harmony/service_locator.dart';

class CreateTopPicksBlock implements Usecase<Either,dynamic> {
  
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<SongsRepository>().createTopPicksBlock();
  } 

}
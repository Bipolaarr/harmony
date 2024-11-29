import 'package:get_it/get_it.dart';
import 'package:harmony/data/repoimpls/auth_repository_implementation.dart';
import 'package:harmony/data/repoimpls/songs_repository_implementation.dart';
import 'package:harmony/data/sources/auth_fb_service.dart';
import 'package:harmony/data/sources/songs_fb_service.dart';
import 'package:harmony/domain/repositories/auth/auth.dart';
import 'package:harmony/domain/repositories/song/song.dart';
import 'package:harmony/domain/usecases/get_new_songs.dart';
import 'package:harmony/domain/usecases/signin.dart';
import 'package:harmony/domain/usecases/signup.dart';

final serviceLocator = GetIt.instance; 

Future<void> initDependencies() async { 

  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<SongsFirebaseService>(
    SongsFirebaseServiceImplementation()
  );



  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation() 
  );

  serviceLocator.registerSingleton<SongsRepository>(
    SongsRepositoryImplementation()
  );



  serviceLocator.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );  

  serviceLocator.registerSingleton<SigninUseCase>(
    SigninUseCase()
  );   

  serviceLocator.registerSingleton<GetNewSongsUseCase>(
    GetNewSongsUseCase()
  );      

}
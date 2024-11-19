import 'package:get_it/get_it.dart';
import 'package:harmony/data/repoimpls/auth_repository_implementation.dart';
import 'package:harmony/data/sources/auth_firebase_service.dart';
import 'package:harmony/domain/repositories/auth.dart';

final serviceLocator = GetIt.instance; 

Future<void> initDependencies() async { 

  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImplementation()
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation() 
  );  

}
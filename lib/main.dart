
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harmony/core/configs/theme/app_theme.dart';
import 'package:harmony/firebase_options.dart';
import 'package:harmony/presentation/pages/splash_page.dart';
import 'package:harmony/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb 
    ? HydratedStorage.webStorageDirectory
    : await getApplicationCacheDirectory()  
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  ); 
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: const SplashPage()
    );  


    
  }
}


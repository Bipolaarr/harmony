
import 'package:flutter/material.dart';
import 'package:harmony/core/configs/theme/app_theme.dart';
import 'package:harmony/presentation/pages/splash.dart';

void main() {
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


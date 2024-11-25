import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/presentation/pages/get_started_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SizedBox(
          child: SvgPicture.asset(AppVectors.whiteNamedLogo),
          width: 200,
          height: 200,
        ),
        
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => GetStartedPage()),
    );
  }
}
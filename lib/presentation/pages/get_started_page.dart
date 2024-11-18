import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harmony/common/widgets/basic_app_button.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/presentation/pages/sign_in.dart';
import 'package:harmony/presentation/pages/sign_up.dart';

class GetStartedPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20, 
              horizontal: 40
            ), 
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill, 
                  image: AssetImage(
                    AppImages.introBackGround
                  )
                ), 
            ), 
            child: Column(
              children: [
                SizedBox(
                  child: SvgPicture.asset(AppVectors.whiteNamedLogo),
                  width: 250,
                  height: 250,
                ),
                Spacer(),
                Text(
                  'Let the music flow, feel the Harmony.', 
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white, 
                    fontSize: 24
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                Text(
                  '© 2024 All Right Reserved',
                  style: TextStyle(
                    fontWeight: FontWeight.w300, 
                    color: AppColors.grey, 
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 14,),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context) => SignInPage()  
                      )
                    );
                  }, //relace with sign in 
                  title: 'Get started',
                    
                ),
                SizedBox(height: 14,), 
              ],
            )
          ),
        ],
      )
    ); 
  }



}
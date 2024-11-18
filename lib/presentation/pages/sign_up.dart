import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/presentation/pages/sign_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bluredBackGround),
                fit: BoxFit.fill
              )
            ),
          ),
          Center(
            child: Container(
              height: 500,
              width: 350, 
              decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [ 
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 10,
                    blurRadius: 40,
                    offset: Offset(0, 0)
                  )
                ]
              ),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AppVectors.whiteLogo,
                      height: 40,
                       width: 40,
                      ),
                      SizedBox(height: 40,),
                    _registerLabel(),
                    SizedBox(height: 15,),
                    _EmailField(),
                    SizedBox(height: 15,),
                    _UsernameField(),
                    SizedBox(height: 15,),
                    _PasswordField(),
                    SizedBox(height: 35,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        )
                      ),
                      onPressed: () { }, 
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w900, 
                        color: Colors.black, 
                        fontSize: 22
                        ), 
                      )
                    ),
                    SizedBox(height: 4,),
                    _SignInText(context)
                  ],
                )
              )
            )
          ), 
        ],
      )
    );
  }

  Widget _registerLabel() {
    return const Text(
      'Create account', 
      style: TextStyle(
        fontFamily: 'SF Pro',
        fontWeight: FontWeight.w900,
        color: Colors.white, 
        fontSize: 22, 
      )
    );
  }
}

Widget _UsernameField() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Username',
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300, 
        color: AppColors.grey, 
        fontSize: 14
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.darkGrey), // Default border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.darkGrey), // Color when enabled
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.white), // Color when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.red), // Color when error
      ),
    ),
  ); 
}

Widget _EmailField() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Email adress',
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300, 
        color: AppColors.grey, 
        fontSize: 14
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.darkGrey), // Default border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.darkGrey), // Color when enabled
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.white), // Color when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.red), // Color when error
      ),
    ),
  );  
}

Widget _PasswordField() {
  return TextField(
    decoration: InputDecoration(
      hintText: 'Password',
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300, 
        color: AppColors.grey, 
        fontSize: 14
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.darkGrey), // Default border color
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: AppColors.darkGrey), // Color when enabled
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.white), // Color when focused
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.red), // Color when error
      ),
    ),
  ); 
}

Widget _SignInText(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Do you have an account?',
          style: TextStyle(
            fontWeight: FontWeight.w300, 
            color: AppColors.grey, 
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (BuildContext context) => SignInPage()
              )
            );
          }, 
          child: Text('Sign in',
          style: TextStyle(
            fontWeight: FontWeight.w300, 
            color: Colors.white, 
            fontSize: 14,
          ),
        ),
        )
      ],
    ),
  );
}
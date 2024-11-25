import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/data/models/signin_user_req.dart';
import 'package:harmony/domain/usecases/signin.dart';
import 'package:harmony/presentation/pages/root_page.dart';
import 'package:harmony/presentation/pages/sign_up_page.dart';
import 'package:harmony/service_locator.dart';

class SignInPage extends StatelessWidget {

  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              height: 455,
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
                      SizedBox(height: 60,),
                    _signInLabel(),
                    SizedBox(height: 15,),
                    _EmailField(),
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
                      onPressed: () async { 
                        var result = await serviceLocator<SigninUseCase>().call(                        
                          params: SigninUserReq(
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString(),
                          ),
                        );
                        result.fold(
                          (l){
                            var snackbar = SnackBar(
                              content: Text(
                                l,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                ),
                              // width: 350,
                              backgroundColor: AppColors.darkBackground,
                              duration: Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(top: 0, left: 10, right: 10), // Adjust top margin
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }, 
                          (r){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => RootPage()), (route) => false);
                          }
                        );
                      }, 
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w900, 
                        color: Colors.black, 
                        fontSize: 22
                        ), 
                      )
                    ),
                    SizedBox(height: 4,),
                    _SignUpText(context)
                  ],
                )
              )
            )
          ), 
        ],
      )
    );
  }

  Widget _signInLabel() {
    return const Text(
      'Welcome back', 
      style: TextStyle(
        fontFamily: 'SF Pro',
        fontWeight: FontWeight.w900,
        color: Colors.white, 
        fontSize: 22, 
      )
    );
  }

  Widget _EmailField() {
  return TextField(
    controller: _emailController,
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
      controller: _passwordController,
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

  Widget _SignUpText(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Dont have an account?',
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
                MaterialPageRoute(builder: (BuildContext context) => SignUpPage()  
                )
              );
            }, 
            child: Text('Create here',
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

}

// Widget _NameField() {
//   return Container(); 
// }


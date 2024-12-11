import 'package:flutter/material.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/data/models/update_user_req.dart';
import 'package:harmony/domain/usecases/update_user.dart';
import 'package:harmony/presentation/pages/sign_in_page.dart';
import 'package:harmony/service_locator.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SF Pro',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Just pop the current route
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.topPicksBlockBackground),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ // Move the container up by 30 pixels
                Container(
                  height: 520,
                  width: 350,
                  decoration: BoxDecoration(
                    color: AppColors.darkBackground,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 10,
                        blurRadius: 40,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(height: 10),
                        _registerLabel(),
                        const SizedBox(height: 15),
                        _emailField(),
                        const SizedBox(height: 15),
                        _usernameField(),
                        const SizedBox(height: 15),
                        _passwordField(),
                        const SizedBox(height: 15),
                        _passwordCheckField(),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(400, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () async {
                            var result = await serviceLocator<UpdateUserUseCase>().call(
                              params: UpdateUserReq(
                                username: _usernameController.text.isNotEmpty ? _usernameController.text : null,
                                email: _emailController.text.isNotEmpty ? _emailController.text : null,
                                newPassword: _newPasswordController.text.isNotEmpty ? _newPasswordController.text : null,
                                currentPassword: _currentPasswordController.text,
                              ),
                            );

                            result.fold(
                              (error) {
                                var snackbar = SnackBar(
                                  content: Text(
                                    error,
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: AppColors.darkBackground,
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              },
                              (successMessage) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
                                  (route) => false,
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Update Profile',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerLabel() {
    return const Text(
      'Edit Your Credentials',
      style: TextStyle(
        fontFamily: 'SF Pro',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }

  Widget _usernameField() {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'New Username (Optional)',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: AppColors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'New Email Address (Optional)',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: AppColors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _newPasswordController,
      decoration: InputDecoration(
        hintText: 'New Password (Optional)',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: AppColors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _passwordCheckField() {
    return TextField(
      controller: _currentPasswordController,
      decoration: InputDecoration(
        hintText: 'Current Password (Required to save)',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: AppColors.grey,
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.darkGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
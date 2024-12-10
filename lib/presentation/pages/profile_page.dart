import 'package:flutter/material.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/theme/app_colors.dart'; 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 254, 254),
        elevation: 0,
        scrolledUnderElevation: 0,
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
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                    _profileInfo(context)
                ],
            )
        ),
      )
    );
  }

  Widget _profileInfo(BuildContext) {   
    
    return InkWell(
        onTap: () {

        },
        highlightColor: AppColors.grey,
        borderRadius: BorderRadius.circular(40),
        child: Padding(
            padding: EdgeInsets.only(bottom: 5),
                child: Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)
                    ),
                    image: const DecorationImage(
                        image: AssetImage(AppImages.topPicksBlockBackground),
                        fit: BoxFit.cover,
                    ),
                ),
            ),
        ),
    );

  }
}
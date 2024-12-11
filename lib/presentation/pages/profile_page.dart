import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/presentation/bloc/profile_info_cubit.dart';
import 'package:harmony/presentation/bloc/profile_info_state.dart'; 

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

  Widget _profileInfo(BuildContext context) {
    return InkWell(
        onTap: () {},
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40)
        ),
        child: BlocProvider(
            create: (context) => ProfileInfoCubit()..getUser(),
            child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                builder: (context, state) {
                    if (state is ProfileInfoLoading) {
                    return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                        color: Colors.white,
                        ),
                    );
                    }
                    if (state is ProfileInfoLoaded) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Container(
                                height: 300,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40),
                                    bottomRight: Radius.circular(40),
                                    ),
                                    image: const DecorationImage(
                                    image: AssetImage(AppImages.topPicksBlockBackground),
                                    fit: BoxFit.cover,
                                    ),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                                    crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
                                        children: [
                                            Icon(
                                                Icons.account_circle_rounded,
                                                color: Colors.black,
                                                size: 120,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                                '${state.userEntity.username}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "SF Pro",
                                                    fontSize: 40,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black
                                                ),
                                            ),
                                            // Text(
                                            //     '${state.userEntity.email}',
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         fontFamily: "SF Pro",
                                            //         fontSize: 20,
                                            //         fontWeight: FontWeight.w500,
                                            //         color: Colors.black
                                            //     ),
                                            // ),
                                            const SizedBox(height: 90,),
                                            Text(
                                                'Click to Edit Your Profile',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "SF Pro",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    );
                    }
                    if (state is ProfileInfoLoadindFailed) {
                    return const Text('Please try again');
                    }

                    return Container();
                },
            ),
        ),
    );
    }

}
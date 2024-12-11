import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/common/widgets/basic_app_button.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/presentation/bloc/favourite_songs_cubit.dart';
import 'package:harmony/presentation/bloc/favourite_songs_state.dart';
import 'package:harmony/presentation/bloc/profile_info_cubit.dart';
import 'package:harmony/presentation/bloc/profile_info_state.dart';
import 'package:harmony/presentation/pages/get_started_page.dart';
import 'package:harmony/presentation/pages/song_player_page.dart';
import 'package:harmony/presentation/pages/update_profile.dart';
import 'package:harmony/presentation/widgets/favourite_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 30,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            _profileInfo(context),
            const SizedBox(height: 0),
            Expanded(child: _favouriteSongs()),
            const SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: BasicAppButton(
                    height: 60,
                    onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => GetStartedPage()),
                          (route) => false, // This will clear all previous routes
                        );
                    }, //relace with sign in 
                    title: 'Log Out', 
                    ),
            ),
            const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return InkWell(
        onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => UpdateProfilePage(),
            ),
        );
        },
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
        ),
        child: BlocProvider(
        create: (context) => ProfileInfoCubit()..getUser(),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
            if (state is ProfileInfoLoading) {
                return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: Colors.white),
                );
            }
            if (state is ProfileInfoLoaded) {
                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                        height: 250,
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
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                style: const TextStyle(
                                fontFamily: "SF Pro",
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                                'Click to Edit Your Profile',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                fontFamily: "SF Pro",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                ),
                            ),
                            ],
                        ),
                        ),
                    ),
                    ),
                ],
                );
            }
            if (state is ProfileInfoLoadindFailed) {
                return Container(); // Handle loading failure
            }
            return Container();
            },
        ),
        ),
    );
    }

  Widget _favouriteSongs() {
    return BlocProvider(
      create: (context) => FavouriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<FavouriteSongsCubit, FavouriteSongsState>(
          builder: (context, state) {
            if (state is FavouriteSongsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (state is FavouriteSongsLoaded) {
              return ListView.builder(
                itemCount: state.favouriteSongs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongPlayerPage(
                            songs: state.favouriteSongs,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 75,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.darkBackground, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(state.favouriteSongs[index].coverImageUrl),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.favouriteSongs[index].title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.favouriteSongs[index].artist,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            ),
                            FavouriteButton(
                                        song: state.favouriteSongs[index],
                                        key: UniqueKey(),
                                        size: 35,
                                        function: (){
                                        context.read<FavouriteSongsCubit>().removeSong(index);
                                        },
                            )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is FavouriteSongsLoadingFailed) {
              return const Center(child: Text('Please try again.', style: TextStyle(color: Colors.white)));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
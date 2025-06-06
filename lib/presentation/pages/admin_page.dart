import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/common/widgets/basic_app_button.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/presentation/bloc/all_songs_cubit.dart';
import 'package:harmony/presentation/bloc/all_songs_state.dart';
import 'package:harmony/presentation/bloc/all_users_cubit.dart';
import 'package:harmony/presentation/bloc/all_users_state.dart';
import 'package:harmony/presentation/bloc/profile_info_cubit.dart';
import 'package:harmony/presentation/bloc/profile_info_state.dart';
import 'package:harmony/presentation/pages/get_started_page.dart';
import 'package:harmony/presentation/pages/update_profile.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 30,
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SF Pro',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            _profileInfo(context),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(Icons.assignment_ind_rounded, size: 45,),
                  const SizedBox(width: 5),
                  Text(
                    'Users',
                    style: TextStyle(
                      fontFamily: "SF Pro",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),              
            const SizedBox(height: 10),
            Expanded(child: _allUsers()),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(Icons.library_music_rounded, size: 45,),
                  const SizedBox(width: 5),
                  Text(
                    'Songs',
                    style: TextStyle(
                      fontFamily: "SF Pro",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: _allSongs()),
            const SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: BasicAppButton(
                    height: 60,
                    onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => GetStartedPage()),
                          (route) => false, 
                        );
                    }, 
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

  Widget _allUsers() {
    return BlocProvider(
      create: (context) => AllUsersCubit()..getAllUsers(),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: BlocBuilder<AllUsersCubit, AllUsersState>(
          builder: (context, state) {
            if (state is AllUsersLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (state is AllUsersLoaded) {
              return ListView.builder(
                itemCount: state.allUsers.length, 
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Optional: Add tap action here if needed
                    },
                    child: Container(
                      height: 70,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.darkBackground, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.assignment_ind_rounded, size: 35),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.allUsers[index].username ?? 'Unknown', // Display username
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.allUsers[index].email ?? 'Unknown', // Display email
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Add buttons to block or delete the user
                              ],
                            ),
                          ),
                          if (state.allUsers[index].role != 'admin')
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  context.read<AllUsersCubit>().blockUser(state.allUsers[index]);
                                },
                                icon: state.allUsers[index].isBlocked ?  Icon(Icons.check) : Icon(Icons.block_rounded)
                              ),
                              IconButton(
                                onPressed: () async {
                                  context.read<AllUsersCubit>().deleteUser(state.allUsers[index].uid!);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ), 
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is AllUsersLoadingFailed) {
              return const Center(child: Text('Failed to load users. Please try again.', style: TextStyle(color: Colors.white)));
            }
            return Container(); // Return an empty container for unhandled states
          },
        ),
      ),
    );
  }

  Widget _allSongs() {
    return BlocProvider(
      create: (context) => AllSongsCubit()..getAllSongs(),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: BlocBuilder<AllSongsCubit, AllSongsState>(
          builder: (context, state) {
            if (state is AllSongsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (state is AllSongsLoaded) {
              print(state.allSongs.toString());
              return ListView.builder(
                itemCount: state.allSongs.length, 
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Optional: Add tap action here if needed
                    },
                    child: Container(
                      height: 70,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.darkBackground, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.library_music_rounded, size: 35),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.allSongs[index].title , // Display username
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  state.allSongs[index].artist , // Display email
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // Add buttons to block or delete the user
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  context.read<AllSongsCubit>().deleteSong(state.allSongs[index].songId);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ), 
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is AllSongsLoadingFailed) {
              return const Center(child: Text('Failed to load users. Please try again.', style: TextStyle(color: Colors.white)));
            }
            return Container(); // Return an empty container for unhandled states
          },
        ),
      ),
    );
  }
}
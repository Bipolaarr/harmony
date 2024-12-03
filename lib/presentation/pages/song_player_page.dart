import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/Constansts/app_urls.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/song_player_cubit.dart';
import 'package:harmony/presentation/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget{

  final SongEntity song; 

  const SongPlayerPage({required this.song});


  @override
  Widget build(BuildContext context) {

    final songUrl = AppUrls.firestorageSongs + Uri.encodeComponent(song.artist + 
                      ' - ' + song.title + '.mp3') + '?' + AppUrls.mediaAlt;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SF Pro',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => SongPlayerCubit()..loadSong(songUrl),
          child: Column(
            children: [
              _songCover(context),
              _songDetails(context),
              _songPlayer(),
            ], 
          ),
        ),
      )
    );

  }

  Widget _songCover(BuildContext context) {

    final coverUrl = AppUrls.firestorageAlbumCovers + Uri.encodeComponent(song.artist + 
                      ' - ' + song.album + '.jpg') + '?' + AppUrls.mediaAlt;

    return Padding(
      padding: EdgeInsets.only(top: 50,),
      child: Container(
        height: 350,
        width: 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              coverUrl,        
            ),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(25)
        ),
      ),
    );

  }

  Widget _songDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 25, right: 20), // Add right padding for better layout
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space between children
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${song.title}',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF Pro',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${song.artist}',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'SF Pro',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Center(
            child: IconButton(
              onPressed: () {
                // Handle the button press
              },
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.grey,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _songPlayer() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10),
      child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          if (state is SongPlayerLoading) {
            return CircularProgressIndicator(color: Colors.white);
          }
          if (state is SongPlayerLoaded) {
            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6.0, // Увеличьте высоту трека
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Увеличьте размер thumb
                  ),
                  child: Slider(
                    thumbColor: Colors.white,
                    activeColor: Colors.grey,
                    value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                    min: 0.0,
                    max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                    onChanged: (value) {
                      final newPosition = Duration(seconds: value.toInt());
                      context.read<SongPlayerCubit>().seekTo(newPosition);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          formatDuration(context.read<SongPlayerCubit>().songPosition),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'SF Pro',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: Text(
                          formatDuration(context.read<SongPlayerCubit>().songDuration),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'SF Pro',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          // Handle previous song
                        },
                        highlightColor: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkBackground,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.skip_previous_rounded,
                              size: 75,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Reduced space between buttons
                    Center(
                      child: InkWell(
                        onTap: () {
                          context.read<SongPlayerCubit>().playOrPauseSong();
                        },
                        highlightColor: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkBackground,
                          ),
                          child: Center(
                            child: Icon(
                              context.read<SongPlayerCubit>().audioPlayer.playing
                                  ? Icons.pause
                                  : Icons.play_circle_fill_outlined,
                              size: 75,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Reduced space between buttons
                    Center(
                      child: InkWell(
                        onTap: () {
                          // Handle next song
                        },
                        highlightColor: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.darkBackground,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.skip_next_rounded,
                              size: 75,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          if (state is SongPlayerLoadingFailed) {
            return Container(); // Handle loading failed state
          }

          return Container();
        },
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }


}


 
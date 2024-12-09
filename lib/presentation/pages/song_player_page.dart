import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/Constansts/app_urls.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/song_player_cubit.dart';
import 'package:harmony/presentation/bloc/song_player_state.dart';
import 'package:harmony/presentation/pages/home_page.dart';
import 'package:harmony/presentation/widgets/favourite_button.dart';

// ignore: must_be_immutable
class SongPlayerPage extends StatelessWidget{

  final List<SongEntity> songs; 
  int index;
  

  SongPlayerPage({super.key, required this.songs, required this.index});

  String getURL() { 
    final songUrl = AppUrls.firestorageSongs + Uri.encodeComponent(songs[index].artist + 
                      ' - ' + songs[index].title + '.mp3') + '?' + AppUrls.mediaAlt;
    return songUrl;
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => SongPlayerCubit()..loadPlaylist(songs, index),
      child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: true,
            title: const Text(
              'Now Playing',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'SF Pro',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () { 
              final songPlayerCubit = context.read<SongPlayerCubit?>();
                if (songPlayerCubit != null) {
                  songPlayerCubit.audioPlayer.stop();
                  songPlayerCubit.close();
                }
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()), // Замените HomePage на ваш виджет
                   // Удалить все предыдущие маршруты
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child:  Column(
                children: [
                  _songCover(context),
                  _songDetails(context),
                  _songPlayer(),
                ], 
              ),
            ),  
        ),
    );

  }

    Widget _songCover(BuildContext context) {
      return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        final cubit = context.read<SongPlayerCubit>();
        final currentSong = cubit.playlist[cubit.currentSongIndex];
        final coverUrl = AppUrls.firestorageAlbumCovers + 
                        Uri.encodeComponent('${currentSong.artist} - ${currentSong.album}.jpg') + 
                        '?' + AppUrls.mediaAlt;

        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(coverUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        );
      },
    );
  }

  Widget _songDetails(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        final cubit = context.read<SongPlayerCubit>();
        final currentSong = cubit.playlist[cubit.currentSongIndex];

        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 25, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2, // Adjust the flex as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${currentSong.title}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF Pro',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                    Text(
                      '${currentSong.artist}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'SF Pro',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10), // Add space between text and icon
              Center(
                child: FavouriteButton(song: songs[index], size: 40.0),
              )
            ]
          ),
        );
      },
    );
  }

  Widget _songPlayer() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          if (state is SongPlayerLoading) {
            return const CircularProgressIndicator(color: Colors.white);
          }
          if (state is SongPlayerLoaded) {

            final cubit = context.read<SongPlayerCubit>();

            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 6.0, 
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0), 
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
                          style: const TextStyle(
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
                          style: const TextStyle(
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          cubit.isRepeated ? cubit.isRepeated = false : cubit.isRepeated = true;
                        },
                        highlightColor: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.repeat_rounded,
                                size: 25,
                                color: cubit.isRepeated? Colors.white : AppColors.darkGrey,
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          context.read<SongPlayerCubit>().previousSong();
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 65,
                          color: Colors.white,
                          )
                      ),
                    ),
                    const SizedBox(width: 10), 
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
                          decoration: const BoxDecoration(
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
                    const SizedBox(width: 10), 
                    Center(
                      child: IconButton(
                        onPressed: () {
                          context.read<SongPlayerCubit>().nextSong();
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 65,
                          color:Colors.white,
                          )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Center(
                      child: InkWell(
                        onTap: () {
                          cubit.isShuffled ? cubit.isShuffled = false : cubit.isShuffled = true;
                        },
                        highlightColor: AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shuffle_rounded,
                                size: 25,
                                color: cubit.isShuffled? Colors.white : AppColors.darkGrey,
                              ),
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 15), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      const Icon(Icons.volume_down_rounded, color: Colors.white), 
                      const SizedBox(width: 1), 
                      Expanded(
                        child: Slider(
                          value: state.volume, 
                          thumbColor: Colors.white,
                          activeColor: Colors.grey,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (value) {
                            context.read<SongPlayerCubit>().setVolume(value);
                          },
                        ),
                      ),
                      const Icon(Icons.volume_up_rounded, color: Colors.white), 
                      const SizedBox(width: 1),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is SongPlayerLoadingFailed) {
            return Container(); 
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


 
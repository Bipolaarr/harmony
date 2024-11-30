import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/Constansts/app_urls.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/new_songs_cubit.dart';
import 'package:harmony/presentation/bloc/new_songs_state.dart';

class NewSongs extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit,NewSongsState>(
          builder: (context,state) {

            if (state is NewSongsLoading) { 
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ));
            }
            if (state is NewSongsLoaded) {
              return _newSongs(state.songs);
            }
            if (state is NewSongsLoadingFailed) {

            }

            return Container();
          }
        ),
        
      )
    );

  }

  Widget _newSongs(List<SongEntity> songs) {
  
  return ListView.separated(
    padding: EdgeInsets.only(left: 15, right: 15),
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      String imageUrl = AppUrls.firestorageAlbumCovers + 
                        Uri.encodeComponent(songs[index].artist + 
                        ' - ' + songs[index].album + '.jpg') + 
                        '?' + AppUrls.mediaAlt;
      print(imageUrl);
      return InkWell(
        onTap: () {
          print('Tapped on: ${songs[index].title} by ${songs[index].artist}');
        },
        highlightColor: AppColors.grey,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
          child: SizedBox(
          width: 200,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  songs[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                songs[index].album,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                  songs[index].artist,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        )
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 15),
    itemCount: songs.length,
  );
}


}


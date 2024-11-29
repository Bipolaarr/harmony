import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/Constansts/app_urls.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/artist/artist.dart';
import 'package:harmony/presentation/bloc/all_artists_cubit.dart';
import 'package:harmony/presentation/bloc/all_artists_state.dart';


class AllArtists extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => AllArtistsCubit()..getAllArtists(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<AllArtistsCubit,AllArtistsState>(
          builder: (context,state) {

            if (state is AllArtistsLoading) { 
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ));
            }
            if (state is AllArtistsLoaded) {
              return _allArtists(state.artists);
            }
            if (state is AllArtistLoadingFailed) {

            }

            return Container();
          }
        ),
        
      )
    );

  }

  Widget _allArtists(List<ArtistEntity> artists) {
  
  return ListView.separated(
    padding: EdgeInsets.only(left: 15, right: 15),
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      String artistUrl = AppUrls.firestorageArtistCovers + 
                        Uri.encodeComponent(artists[index].name + 
                        '.jpg') + 
                        '?' + AppUrls.mediaAlt;
      print('Image URL for ${artists[index].name}: $artistUrl');
      return InkWell(
        onTap: () {
          print('Tapped on: ${artists[index].name}');
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
                      image: NetworkImage(artistUrl),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  artists[index].name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        )
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 15),
    itemCount: artists.length,
  );
}


}


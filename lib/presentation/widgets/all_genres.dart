import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/genre/genre.dart';
import 'package:harmony/presentation/bloc/all_genres_cubit.dart';
import 'package:harmony/presentation/bloc/all_genres_state.dart';


class AllGenres extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => AllGenresCubit()..getAllGenres(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<AllGenresCubit,AllGenresState>(
          builder: (context,state) {

            if (state is AllGenresLoading) { 
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ));
            }
            if (state is AllGenresLoaded) {
              return _allGenres(state.genres);
            }
            if (state is AllGenresLoadingFailed) {

            }

            return Container();
          }
        ),
        
      )
    );

  }

  Widget _allGenres(List<GenreEntity> genres) {
  
  return ListView.separated(
    padding: EdgeInsets.only(left: 15, right: 15),
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          print('Tapped on: ${genres[index].name}');
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
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(AppImages.genreWidgetBackground), // Use AssetImage instead of Image.asset
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          genres[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF Pro',
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(), // This pushes the smaller text to the bottom
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            genres[index].about,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SF Pro',
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
        )
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 15),
    itemCount: genres.length,
  );
}


}

                  
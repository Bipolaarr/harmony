import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/presentation/bloc/search_resluts_cubit.dart';
import 'package:harmony/presentation/bloc/search_results_state.dart';
import 'package:harmony/presentation/pages/song_player_page.dart';
import 'package:harmony/presentation/widgets/favourite_button.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _queryController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchResultsCubit(), // Provide the cubit here
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.darkBackground,
              scrolledUnderElevation: 0,
              centerTitle: true,
              toolbarHeight: 50,
              title: const Text(
                'Search',
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
                  Navigator.pop(context); // Just pop the current route
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: _queryController,
                    onChanged: (query) {
                      context.read<SearchResultsCubit>().searchSongs(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for songs or artists...',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                        fontSize: 15,
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
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: _foundSongs()), // Call _foundSongs without arguments
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _foundSongs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
        builder: (context, state) {
          if (state is SearchResultsLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is SearchResultsLoaded) {
            return ListView.builder(
              itemCount: state.foundSongs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPlayerPage(
                          songs: state.foundSongs,
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
                              image: NetworkImage(state.foundSongs[index].coverImageUrl),
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
                                state.foundSongs[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                state.foundSongs[index].artist,
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
                        FavouriteButton(song: state.foundSongs[index],size: 35.0),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is SearchResultsLoadingFailed) {
            return const Center(child: Text('Please try again.', style: TextStyle(color: Colors.white)));
          }
          return Container();
        },
      ),
    );
  }
}
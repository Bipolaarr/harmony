import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/top_pick_blocks_state.dart';
import 'package:harmony/presentation/bloc/top_picks_block_cubit.dart';
import 'package:harmony/presentation/pages/playlist_page.dart';

class TopPickContainer extends StatelessWidget {
  final List<String> indx; // Поле для indx

  TopPickContainer({required this.indx});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopPicksBlockCubit()..buildTopPicksBlock(),
      child: SizedBox(
        height: 280,
        child: BlocBuilder<TopPicksBlockCubit, TopPickBlocksState>(
          builder: (context, state) {
            if (state is TopPicksBlockLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            if (state is TopPicksBlockLoaded) {
              return _topPicksList(state.pickedSongs);
            }
            if (state is TopPicksBlockFailed) {
              
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _topPicksList(List<List<SongEntity>> pickedSongs) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        String currentIndex = indx[index % indx.length];

        return InkWell(
          onTap: () {
            print('Tapped on: ${currentIndex}');
            print(pickedSongs[index]);
              Navigator.push( context,
            MaterialPageRoute(builder: (context) => PlaylistPage(songs: pickedSongs[index], title: 'Top Picks for You, _Username')));
          },
          highlightColor: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: 200,
              height: 270, // Установите желаемую ширину
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(AppImages.topPicksBlockBackground),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              currentIndex,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SF Pro',
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${pickedSongs[index][0].artist}, ' + '${pickedSongs[index][1].artist}, ' + '${pickedSongs[index][2].artist}, ' + ' and others', // Отображение артиста
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SF Pro',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemCount: pickedSongs.length < indx.length ? pickedSongs.length : indx.length, // Проверяем длину
    );
  }
}
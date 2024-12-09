import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/bloc/top_pick_blocks_state.dart';
import 'package:harmony/presentation/bloc/top_picks_block_cubit.dart';
import 'package:harmony/presentation/pages/playlist_page.dart';

class TopPickContainer extends StatelessWidget {
  final List<String> indx;

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
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }
            if (state is TopPicksBlockLoaded) {
              return _topPicksList(state.pickedSongs);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _topPicksList(List<List<SongEntity>> pickedSongs) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        String currentIndex = indx[index % indx.length];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaylistPage(songs: pickedSongs[index], title: 'Top Picks for You'),
              ),
            );
          },
          child: Container(
            width: 200,
            height: 270,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      image: const DecorationImage(
                        image: AssetImage(AppImages.topPicksBlockBackground),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentIndex, style: const TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w700)),
                          const Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${pickedSongs[index][0].artist}, ${pickedSongs[index][1].artist}, ${pickedSongs[index][2].artist}, and others',
                              style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
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
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 15),
      itemCount: pickedSongs.length < indx.length ? pickedSongs.length : indx.length,
    );
  }
}
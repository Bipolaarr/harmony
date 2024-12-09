import 'package:flutter/material.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/pages/song_player_page.dart';
import 'package:harmony/presentation/widgets/favourite_button.dart';

class PlaylistPage extends StatelessWidget {
  final List<SongEntity> songs;
  final String title;

  const PlaylistPage({super.key, required this.songs, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return _elementContainer(context, songs[index], index);
        },
      ),
    );
  }

  Widget _elementContainer(BuildContext context, SongEntity song, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SongPlayerPage(songs: songs, index: index)),
        );
      },
      child: Container(
        height: 70,
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.darkBackground, width: 1))),
        child: Row(
          children: [
            // Cover image
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(song.coverImageUrl)),
              ),
            ),
            const SizedBox(width: 20),
            // Title and artist
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis),
                  Text(song.artist, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            // Favorite button
            FavouriteButton(song: song, size: 35.0),
          ],
        ),
      ),
    );
  }
}
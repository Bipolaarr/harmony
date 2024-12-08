import 'package:flutter/material.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/entities/song/song.dart';
import 'package:harmony/presentation/pages/song_player_page.dart';

class PlaylistPage extends StatelessWidget {
  final List<SongEntity> songs; // List of songs
  final String title;

  PlaylistPage({required this.songs, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Fixed header
          Container(
            height: 90,
            color: Colors.transparent, // Set background to transparent
            padding: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),

          // Scrollable list view
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return _element_container(context, songs[index], index); // Pass context and index
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _element_container(BuildContext context, SongEntity song, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongPlayerPage(songs: songs, index: index),
          ),
        );
      },
      child: Container(
        height: 70,
        width: double.infinity, // Use full width of the parent
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkBackground,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Cover image container
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(song.coverImageUrl), // Use the song URL
                ),
              ),
            ),
            SizedBox(width: 20),
            // Song title and artist
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(
                    song.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SF Pro',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SF Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ],
              ),
            ),
            // Favorite icon button
            IconButton(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                // Handle favorite button press
              },
            ),
          ],
        ),
      ),
    );
  }
}
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:harmony/domain/usecases/get_songs_by_artist.dart';
import 'package:harmony/presentation/pages/playlist_page.dart';
import 'package:harmony/presentation/pages/profile_page.dart';
import 'package:harmony/presentation/pages/search_page.dart';
import 'package:harmony/presentation/widgets/all_artists.dart';
import 'package:harmony/presentation/widgets/all_genres.dart';
import 'package:harmony/presentation/widgets/new_songs.dart';
import 'package:harmony/presentation/widgets/top_pick_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController _tabController; 

  @override
  void initState() {

    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: 70,
        title: SvgPicture.asset(
          AppVectors.whiteNamedLogo,
          height: 40,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()));
              }, icon: 
              Icon(
                Icons.search,
                size: 35,
                color: Colors.white
              )
            ) 
          )
        ],
      ),
      body: SingleChildScrollView(  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Center(
              child: _RecBannerClickable()
            ),
            Center(
              child: _tabs()
            ),
            SizedBox(
              height: 270,
              child: TabBarView(
                controller: _tabController,
                children: [
                  NewSongs(),
                  const AllArtists(),
                  AllGenres()
                  
                ],
              ),
            ),
            const SizedBox(height: 10,), 
            const Padding(
              padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Top Picks for You',
                    style: TextStyle(
                    fontFamily: "SF Pro", 
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 10,),
            TopPickContainer(indx: const ['#1','#2','#3','#4','#5'],),
            const Padding(
              padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Profile',
                    style: TextStyle(
                    fontFamily: "SF Pro", 
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: Colors.white,
                  )
                )
              ),
            ),
            const SizedBox(height: 10,),
            _homePageWidget(),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }

  Widget _RecBannerClickable() {
    return InkWell(
      onTap: () async {
        final result = await GetSongsByArtist().call(params: 'Pop Smoke');
          result.fold(
            (error) {
              print('Error: $error');
            },
            (songs) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaylistPage(songs: songs, title: 'Pop Smoke Essentials')),
              );
            },
          );
      },
      highlightColor: AppColors.grey,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Закругление контейнера
        child: Container(
          height: 150,
          width: 350,
          decoration: const BoxDecoration(
            color: Color(0xffF3F3F3),
          ),
          child: const Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 110, right: 150), // Увеличен отступ справа
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Editor's Сhoice",
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 21, 
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 60, right: 150), // Увеличен отступ справа
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Pop Smoke Essentials: The King of NY Drill',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontSize: 16, 
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                right: -20,  
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image(
                    image: AssetImage(AppImages.recBannerImage),
                    height: 175,
                    width: 165, 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),)
    );
  }
  
  Widget _tabs() {
  return TabBar(
    padding: const EdgeInsets.all(10),
    dividerColor: Colors.transparent,
    splashBorderRadius: BorderRadius.circular(20),
    controller: _tabController,
    labelColor: Colors.white,
    unselectedLabelColor: const Color(0xff7A7A7A),
    isScrollable: false,
    indicator: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20) 
    ),
    indicatorWeight: 0,
    indicatorSize: TabBarIndicatorSize.tab,
    tabs: const [
      Tab(
        child: Text(
          'New Songs',
          style: TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          'Artists',
          style: TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          'Genres',
          style: TextStyle(
            fontFamily: 'SF Pro',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

Widget _homePageWidget() {

  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
    },
    highlightColor: AppColors.grey,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Закругление контейнера
        child: Container(
          height: 75,
          width: 350,
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(AppImages.topPicksBlockBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8,),
                child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: 60,
                ),
              ),
              // SizedBox(width: 5,),
              // Text(
              //   "Uncover My Essence",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontFamily: "SF Pro",
              //     fontSize: 26,
              //     fontWeight: FontWeight.w700,
              //     color: Colors.black
              //   ),
              //   )
            ],
          ),
        ),
      )
    ),
  );

}

}
    
  
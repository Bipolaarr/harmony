import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harmony/core/configs/assets/app_images.dart';
import 'package:harmony/core/configs/assets/app_vectors.dart';
import 'package:harmony/core/configs/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
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
        title: SvgPicture.asset(
          AppVectors.whiteNamedLogo,
          height: 40,
        ),
      ),
      body: SingleChildScrollView(  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
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
                  AllArtists(),
                  AllGenres()
                  
                ],
              ),
            ),
            SizedBox(height: 10,), 
            Padding(
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
            SizedBox(height: 10,),
            TopPickContainer(indx: ['#1','#2','#3','#4','#5'],),
          ],
        ),
      ),
    );
  }

  Widget _RecBannerClickable() {
    return InkWell(
      onTap: () {},
      highlightColor: AppColors.grey,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Закругление контейнера
        child: Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
            color: Color(0xffF3F3F3),
          ),
          child: Stack(
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
                    width: 175, 
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
    padding: EdgeInsets.all(10),
    dividerColor: Colors.transparent,
    splashBorderRadius: BorderRadius.circular(20),
    controller: _tabController,
    labelColor: Colors.white,
    unselectedLabelColor: Color(0xff7A7A7A),
    isScrollable: false,
    indicator: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20) 
    ),
    indicatorWeight: 0,
    indicatorSize: TabBarIndicatorSize.tab,
    tabs: [
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

}
    
  
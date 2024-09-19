import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/home/widgets/news_songs.dart';
import 'package:spotify_clone/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
          hideBack: true,
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _homeTopCard(),
              _tabs(),
              SizedBox(
                height: 260,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const NewsSongs(),
                    Container(),
                    Container(),
                    Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              PlayList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard)),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ))
        ]),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        tabAlignment: TabAlignment.center,
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.primary,
        isScrollable: true,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        tabs: const [
          Text(
            'News',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'Videos',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'Artists',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            'Podcasts',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ]);
  }
}

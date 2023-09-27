import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/search/search_song-event.dart';
import 'package:justaudioplayer/bloc/search/search_song_bloc.dart';
import 'package:justaudioplayer/view/album.dart';
import 'package:justaudioplayer/view/allsong_screen.dart';
import 'package:justaudioplayer/view/favoriy_screen.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/view/directory_list.dart';
import 'package:justaudioplayer/view/playlist_screen.dart';
import 'package:justaudioplayer/view/serach_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'artist_screen.dart';
import 'darwer.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens>
    with SingleTickerProviderStateMixin {
  TabController? tabcontrol;
  var selctedindex = 0;
  List<Widget> pages = [
    AllSongScreen(),
    ArtistScreen(),
    AlbumScreen(),
    PlayListScren(),
    FavoritScreen(),
    const DirectoryListScreen(),
  ];
  List<Tab> tabs = [
    const Tab(
      text: "All",
    ),
    const Tab(
      text: "Artist",
    ),
    const Tab(
      text: "Album",
    ),
    const Tab(
      text: "playlist",
    ),
    const Tab(
      text: "Favorite",
    ),
    const Tab(
      text: "folder",
    ),
  ];
  List<String> listitem = [
    "All",
    "Artist",
    "Album",
    "playlist",
    "Favorite",
    "folder",
  ];
  int curentindex = 0;
  @override
  void initState() {
    super.initState();
    tabcontrol = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawerscreen(),
//------------------------------------------------------------------------------
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            elevation: 0,
            iconTheme: Theme.of(context).iconTheme,
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<Searchbloc>(context).add(SearchSongEvent(""));
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          type: PageTransitionType.fade,
                          child: const SearchScreen()));
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                splashRadius: 20,
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Beat ", style: Theme.of(context).textTheme.headlineLarge),
                Text(" Wave",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20)
                    //Color.fromARGB(255, 31, 192, 36), fontSize: 25),
                    ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: SafeArea(
          child: Column(
            children: [
              tabbar(),
              Expanded(
                  child: IndexedStack(
                index: curentindex,
                children: pages,
              )
                  // TabBarView(
                  //   physics: const BouncingScrollPhysics(),
                  //   controller: tabcontrol,
                  //   children: pages,
                  // ),
                  ),
              Miniplayer(),
            ],
          ),
        ));
  }

  Widget tabbar() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TabBar(
        isScrollable: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        onTap: (value) {
          setState(() {
            curentindex = value;
          });
        },
        // onTap: (value) {
        //   if (value == 0) {
        //     BlocProvider.of<AllSongsBloc>(context).add(AllSongsEvent());
        //   }
        //   if (value == 1) {
        //     BlocProvider.of<ArtistBloc>(context).add(ArtistEvent());
        //   }
        //   if (value == 2) {
        //     BlocProvider.of<AlbumBloc>(context).add(AlbumEvent());
        //   }
        //   if (value == 3) {
        //     BlocProvider.of<PlaylistBloc>(context).add(PlaylistEvent());
        //   }
        //   if (value == 4) {
        //     BlocProvider.of<FavoritSongBloc>(context).add(FavoriteSongeEvent());
        //   }
        //   if (value == 5) {
        //     BlocProvider.of<DirectoryListBloc>(context)
        //         .add(LoadDirectoryListEvent());
        //   }
        // },
        labelPadding: const EdgeInsets.symmetric(horizontal: 20),
        controller: tabcontrol,
        labelStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 13,
        ),
        unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        unselectedLabelColor: Theme.of(context).textTheme.labelSmall!.color,
        labelColor: Colors.white,
        splashBorderRadius: BorderRadius.circular(8),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          },
        ),
        indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
        indicator: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: Theme.of(context).primaryColor),
        tabs: const [
          Tab(
            text: 'All',
          ),
          Tab(
            text: 'Artist',
          ),
          Tab(
            text: 'Album',
          ),
          Tab(
            text: 'Playlist',
          ),
          Tab(
            text: 'Favorit',
          ),
          Tab(
            text: 'Folder',
          ),
        ],
      ),
    );
  }
}

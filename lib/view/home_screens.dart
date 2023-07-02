import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_event.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_envent.dart';
import 'package:justaudioplayer/bloc/homepage/home_state.dart';
import 'package:justaudioplayer/bloc/main_screen/main_screen_bloc.dart';
import 'package:justaudioplayer/bloc/main_screen/main_screen_state.dart';
import 'package:justaudioplayer/bloc/player/player.bloc.dart';
import 'package:justaudioplayer/bloc/player/player_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/view/album.dart';
import 'package:justaudioplayer/view/allsong_screen.dart';
import 'package:justaudioplayer/view/favoriy_screen.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/view/directory_list.dart';
import 'package:justaudioplayer/view/playlist_screen.dart';
import '../bloc/directorylist/directory_list_bloc.dart';
import '../bloc/directorylist/directory_list_event.dart';
import '../bloc/favoritesong/favorite_song_event.dart';
import '../bloc/main_screen/main_screen_envent.dart';
import '../consts/color.dart';
import 'artist_screen.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens>
    with SingleTickerProviderStateMixin {
  TabController? tabcontrol;
  var selctedindex = 0;
  var controller = DraggableScrollableController();
  // List<Widget> pages =  [
  //   AllSongScreen(),
  //   ArtistScreen(),
  //   AlbumScreen(),
  //   PlayListScren(),
  //   FavoritScreen(),
  //   DirectoryListScreen(),
  // ];

  List<String> list = [
    "All",
    "Artist",
    "Album",
    "playlist",
    "Favorite",
    "folder",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabcontrol = TabController(
        length: 6,
        vsync: this,
        animationDuration: const Duration(milliseconds: 600));
    BlocProvider.of<PlayerBloc>(context).add(InitHivePlayerEnent());
    BlocProvider.of<DirectoryListBloc>(context).add(LoadListEvent());
    BlocProvider.of<MainScreenbloc>(context).add(AllSongScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      backgroundColor: const Color(0xff121212),
      // Color.fromARGB(255, 1, 1, 18),
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            splashRadius: 20,
          ),
        ],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My ",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(" Music", style: TextStyle(color: CustomColor.customblue)
                //Color.fromARGB(255, 31, 192, 36), fontSize: 25),
                ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<Homebloc, IHomeState>(builder: (context, state) {
        if (state is HomeState) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: const Color(0xff212121),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ListView.builder(
                          itemCount: list.length,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  BlocProvider.of<Homebloc>(context)
                                      .add(HomeEvent(index));
                                  if (index == 0) {
                                    BlocProvider.of<AllSongsBloc>(context)
                                        .add(AllSongsEvent());
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(AllSongScreenEvent());
                                  }
                                  if (index == 1) {
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(ArtistScreenEvent());
                                  }
                                  if (index == 2) {
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(AlbumScreenEvent());
                                  }
                                  if (index == 3) {
                                    BlocProvider.of<PlaylistBloc>(context)
                                        .add(PlaylistEvent());
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(PlaylistScreenEvent());
                                  }
                                  if (index == 4) {
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(FavoritScreenEvent());
                                    BlocProvider.of<FavoritSongBloc>(context)
                                        .add(FavoriteSongeEvent());
                                  }
                                  if (index == 5) {
                                    BlocProvider.of<MainScreenbloc>(context)
                                        .add(DirectoryScreenEvent());
                                  }
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linear,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        // gradient: const LinearGradient(
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //     colors: [
                                        //       Color.fromARGB(255, 8, 86, 150),
                                        //       Color.fromARGB(255, 43, 13, 193)
                                        //     ]),
                                        color: state.index == index
                                            ? const Color(0xff2962FF)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: Text(
                                      list[index],
                                      style: GoogleFonts.roboto(
                                        color: state.index == index
                                            ? Colors.white
                                            : Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ))));
                          },
                        )),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<MainScreenbloc, IMainScreenState>(
                      builder: (context, state) {
                    if (state is AllSongScreenState) {
                      return AllSongScreen();
                    } else if (state is ArtistScreenState) {
                      return ArtistScreen(
                        artist: state.artistsong,
                      );
                    } else if (state is AlbumScreenState) {
                      return AlbumScreen(
                        album: state.albumsong,
                      );
                    } else if (state is DirectoryScreenState) {
                      return DirectoryListScreen(
                        directrorypath: state.directorylist,
                      );
                    } else if (state is FavoritScreenState) {
                      return FavoritScreen();
                    } else if (state is PlaylistScreenState) {
                      return PlayListScren(false);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),

                  // TabBarView(
                  //   controller: tabcontrol,
                  //   children: pages,
                  // ),
                ),
                Miniplayer(),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),
      // floatingActionButton: const Miniplayer(),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget tabbar() {
    return TabBar(
      isScrollable: true,
      onTap: (value) {
        BlocProvider.of<Homebloc>(context).add(HomeEvent(value));
      },
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      controller: tabcontrol,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'ISW',
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontFamily: 'ISW',
      ),
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.black,
      splashBorderRadius: BorderRadius.circular(50),
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return states.contains(MaterialState.focused)
              ? null
              : Colors.transparent;
        },
      ),
      indicatorPadding: const EdgeInsets.symmetric(vertical: 10),
      indicator: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Colors.white),
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
    );
  }
}

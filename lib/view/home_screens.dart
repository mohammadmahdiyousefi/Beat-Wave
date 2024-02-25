import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justaudioplayer/bloc/album/album_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_event.dart';
import 'package:justaudioplayer/bloc/all_song/all_song_bloc.dart';
import 'package:justaudioplayer/bloc/all_song/all_song_event.dart';
import 'package:justaudioplayer/bloc/all_song/all_song_state.dart';
import 'package:justaudioplayer/bloc/artist/artist_bloc.dart';
import 'package:justaudioplayer/bloc/artist/artist_event.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/data/model/player.dart';
import 'package:justaudioplayer/view/album_screen.dart';
import 'package:justaudioplayer/view/directory_list.dart';
import 'package:justaudioplayer/view/favorit_screen.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/view/playlist_screen.dart';
import 'package:justaudioplayer/view/serach_screen.dart';
import 'package:justaudioplayer/widget/lodingwidget.dart';
import 'package:justaudioplayer/widget/navigator.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:justaudioplayer/widget/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'artist_screen.dart';
import 'darwer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Widget column = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  customNavigator(
                    context: context,
                    page: BlocProvider(
                      create: (context) {
                        var albumBloc = AlbumBloc();
                        albumBloc.add(GetAlbumEvent());
                        return albumBloc;
                      },
                      child: const AlbumScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 65,
                  width: 115,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFff5e62),
                            Color(0xFFff9966),
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.album,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Album",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  customNavigator(
                      context: context,
                      page: BlocProvider(
                        create: (context) {
                          var artistBloc = ArtistBloc();
                          artistBloc.add(GetArtistEvent());
                          return artistBloc;
                        },
                        child: const ArtistScreen(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 115,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF4e54c8),
                            Color(0xFF8f94fb),
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Artist",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  customNavigator(
                      context: context,
                      page: BlocProvider(
                        create: (context) {
                          var directoryListBloc = DirectoryListBloc();
                          directoryListBloc.add(GetDirectoryList());
                          return directoryListBloc;
                        },
                        child: const DirectoryListScreen(),
                      ));
                },
                child: Container(
                  height: 65,
                  width: 115,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF654ea3),
                            Color(0xFFeaafc8),
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.folder_copy,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Folder",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  customNavigator(context: context, page: FavoritScreen());
                },
                child: Container(
                  height: 65,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF7f00ff),
                            Color(0xFFe100ff),
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Favorites",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  customNavigator(
                    context: context,
                    page: BlocProvider(
                      create: (context) {
                        var playlistBloc = PlaylistBloc();
                        playlistBloc.add(GetPlaylistEvent());
                        return playlistBloc;
                      },
                      child: PlayListScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 65,
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1f4037),
                            Color(0xFF348f50),
                          ]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.playlist_play,
                        size: 22,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Playlists",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
    return Scaffold(
      drawer: const Drawerscreen(),
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        scrolledUnderElevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
        actions: const [
          SizedBox(
            width: 16,
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
              splashRadius: 15,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset(
                "assets/svg/burger-menu-icon.svg", height: 15,
                // ignore: deprecated_member_use
                color: Theme.of(context).iconTheme.color,
              ));
        }),

        title: TextField(
            onTap: () {
              customNavigator(context: context, page: const SearchScreen());
            },
            keyboardType: TextInputType.none,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Search songs",

              isDense: true, // Added this
              contentPadding: const EdgeInsets.all(6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 45, maxWidth: 45),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(11),
                child: SvgPicture.asset(
                  "assets/svg/Search.svg",
                  height: 16,
                  width: 16,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            )),
        //centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: BlocProvider(
        create: (context) {
          var allSongBloc = AllSongBloc();
          allSongBloc.add(GetAllSong());
          return allSongBloc;
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 8,
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: column,
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              collapsedHeight: 55,
              toolbarHeight: 0,
              expandedHeight: 55,
              pinned: true,
              scrolledUnderElevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All songs",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    BlocBuilder<AllSongBloc, AllSongState>(
                      builder: (context, state) {
                        return _playandshuffle(
                            context, state is AllSongList ? state.songs : []);
                      },
                    )
                  ],
                ),
              ),
            ),
            BlocBuilder<AllSongBloc, AllSongState>(
              builder: (context, state) {
                if (state is AllSongList) {
                  return SliverList.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) => SongTile(
                      song: state.songs[index],
                      onTap: () async {
                        await PlayerAudio.setAudioSource(state.songs, index);
                      },
                      moreOnTap: () async {
                        await moreBottomSheet(context, state.songs[index]);
                      },
                    ),
                  );
                }
//------------------------------------------------------------------------------
//------------------- loding state ---------------------------------------------
                else if (state is AllSongLoading) {
                  return const SliverFillRemaining(
                      hasScrollBody: false, child: Loading());
                }
//------------------------------------------------------------------------------
//--------------- empety state -------------------------------------------------
                else if (state is AllSongEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/error-icon.svg",
                            // ignore: deprecated_member_use
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.empty,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }
//------------------------------------------------------------------------------
//------------------ error state -----------------------------------------------
                else if (state is AllSongError) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/error-icon.svg",
                            // ignore: deprecated_member_use
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.error,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              onPressed: () {
                                BlocProvider.of<AllSongBloc>(context)
                                    .add(GetAllSong());
                              },
                              child: const Text(
                                "Try again",
                              )),
                        ],
                      ),
                    ),
                  );
                }
//------------------------------------------------------------------------------
//---------------- Other state -------------------------------------------------
                else {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/error-icon.svg",
                            // ignore: deprecated_member_use
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "An unknown error occurred",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {
                                BlocProvider.of<AllSongBloc>(context)
                                    .add(GetAllSong());
                              },
                              child: const Text(
                                "Try again",
                              )),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _playandshuffle(BuildContext context, List<SongModel> songs) {
  final Random random = Random();
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
          onTap: () async {
            if (songs.isNotEmpty) {
              await PlayerAudio.setAudioSource(
                  songs, random.nextInt(songs.length),
                  isShuffle: true);
            }
          },
          child: Container(
            width: 36,
            height: 36,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/svg/shuffle-icon.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context).iconTheme.color,
            ),
          )),
      const SizedBox(
        width: 8,
      ),
      GestureDetector(
          onTap: () async {
            if (songs.isNotEmpty) {
              await PlayerAudio.setAudioSource(
                songs,
                0,
              );
            }
          },
          child: Container(
            width: 36,
            height: 36,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/svg/play-album-icon.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context).iconTheme.color,
            ),
          )),
    ],
  );
}

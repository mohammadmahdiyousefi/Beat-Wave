import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_bloc.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_event.dart';
import 'package:justaudioplayer/bloc/homepage/home_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_state.dart';
import 'package:justaudioplayer/bloc/main_screen/main_screen_bloc.dart';
import 'package:justaudioplayer/bloc/main_screen/main_screen_state.dart';

import 'package:justaudioplayer/bloc/player/player.bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:justaudioplayer/view/home_screens.dart';
import 'bloc/favoritesong/favorite_song_state.dart';
import 'bloc/player/player_state.dart';

Future<void> main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidShowNotificationBadge: true,
      preloadArtwork: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('songlist');
  await Hive.openBox('FavoriteSongs');
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) {
        return PlayerBloc(PlayAudioState(0));
      },
    ),
    BlocProvider(
      create: (context) {
        return AllSongsBloc(InitAllSongs());
      },
    ),
    BlocProvider(
      create: (context) {
        return PlaylistBloc(PlaylistInitState());
      },
    ),
    BlocProvider(
      create: (context) {
        return MainScreenbloc(InitMainScreenState());
      },
    ),
    BlocProvider(
      create: (context) {
        return FavoritSongBloc(FavoriteSongsstete([]));
      },
    ),
    BlocProvider(
      create: (context) {
        return DirectoryListBloc(ListState([]));
      },
    ),
    BlocProvider(
      create: (context) {
        return Homebloc(HomeState(0));
      },
    ),
    BlocProvider(
      create: (context) {
        return SongBloc(SongListState(
          [],
        ));
      },
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreens(),
    );
  }
}

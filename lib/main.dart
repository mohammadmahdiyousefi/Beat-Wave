import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:justaudioplayer/bloc/album/album_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:justaudioplayer/bloc/artist/artist_bloc.dart';
import 'package:justaudioplayer/bloc/artist/artist_state.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_state.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_network_bloc.dart';
import 'package:justaudioplayer/bloc/player/player_bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/bloc/search/search_song_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/model/playlist.dart';
import 'package:justaudioplayer/permission/premission.dart';
import 'package:justaudioplayer/view/home_screens.dart';
import 'package:justaudioplayer/view/splash_screen.dart';
import 'bloc/favoritesong/favorite_song_state.dart';
import 'bloc/player/player_state.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
import 'model/theme_class.dart';

Future<void> main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidShowNotificationBadge: true,
      preloadArtwork: true);
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  await Hive.initFlutter();
  await Hive.openBox('prmission');
  await Hive.openBox('songlist');
  await Hive.openBox('playmode');
  await Hive.openBox('FavoriteSongs');
  await Hive.openBox('NetworkSonglist');
  Hive.registerAdapter(PlaylistAdapter());
  await Hive.openBox<Playlist>("playlist");
  var mode = await Hive.openBox('ThemeMode');
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) {
        return PlayerBloc();
      },
    ),
    BlocProvider(
      create: (context) {
        return AlbumBloc(InitAlbumState());
      },
    ),
    BlocProvider(
      create: (context) {
        return ArtistBloc(InitArtistState());
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
        return FavoritSongBloc(FavoriteSongsstete([]));
      },
    ),
    BlocProvider(
      create: (context) {
        return DirectoryListBloc(LoadDirectoryListState());
      },
    ),
    BlocProvider(
      create: (context) {
        return MusicNetworkBloc();
      },
    ),
    BlocProvider(
      create: (context) {
        if (mode.get("mode") == "dark") {
          if (mode.get("color") == null) {
            mode.put("color", int.parse("ff5368e8", radix: 16));
          }
          return ThemeBloc(DarkThemeState(mode.get("color")));
        } else if (mode.get("mode") == "light") {
          if (mode.get("color") == null) {
            mode.put("color", int.parse("ff5368e8", radix: 16));
          }
          return ThemeBloc(LightThemeState(mode.get("color")));
        } else if (mode.get("mode") == "System") {
          if (mode.get("color") == null) {
            mode.put("color", int.parse("ff5368e8", radix: 16));
          }
          return ThemeBloc(SystemThemeModeState(mode.get("color")));
        } else {
          mode.put("mode", "System");
          if (mode.get("color") == null) {
            mode.put("color", int.parse("ff5368e8", radix: 16));
          }
          return ThemeBloc(SystemThemeModeState(mode.get("color")));
        }
      },
    ),
    BlocProvider(
      create: (context) {
        return Searchbloc(InitSearchState());
      },
    ),
    BlocProvider(
      create: (context) {
        return Homebloc(HomeState());
      },
    ),
    BlocProvider(
      create: (context) {
        return SongBloc(SongListState(
          [],
        ));
      },
    )
  ], child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  var themecolor = Hive.box("ThemeMode");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
        themeAnimationDuration: const Duration(seconds: 0),
        themeMode: state is DarkThemeState
            ? ThemeMode.dark
            : state is LightThemeState
                ? ThemeMode.light
                : ThemeMode.system,
        theme: LightTheme(
                primaryColor: state is LightThemeState
                    ? state.color
                    : int.parse("ff2962FF", radix: 16))
            .lighttheme(),
        darkTheme: DarkTheme(
                primaryColor: state is DarkThemeState
                    ? state.color
                    : int.parse("ff2962FF", radix: 16))
            .darkthem(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(
              state is DarkThemeState ? true : false), // مسیر Splash Screen
          '/home': (context) => const HomeScreens(), // مسیر Home Screen اصلی
        },
        //  home: const HomeScreens(),
      );
    });
  }
}

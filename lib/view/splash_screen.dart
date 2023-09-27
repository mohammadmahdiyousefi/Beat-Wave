import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:justaudioplayer/view/home_screens.dart';
import '../bloc/album/album_bloc.dart';
import '../bloc/album/album_event.dart';
import '../bloc/allsongs/all_songs_bloc.dart';
import '../bloc/allsongs/all_songs_event.dart';
import '../bloc/artist/artist_bloc.dart';
import '../bloc/artist/artist_event.dart';
import '../bloc/directorylist/directory_list_bloc.dart';
import '../bloc/directorylist/directory_list_event.dart';
import '../bloc/favoritesong/favorite_song_bloc.dart';
import '../bloc/favoritesong/favorite_song_event.dart';
import '../bloc/player/player_bloc.dart';
import '../bloc/player/player_event.dart';
import '../bloc/playlist/playlist_bloc.dart';
import '../bloc/playlist/playlist_event.dart';
import '../permission/premission.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  SplashScreen(this.thememode, {super.key});
  bool thememode = false;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = Hive.box('playmode');
  @override
  void initState() {
    super.initState();
    appPremission();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: widget.thememode
                  ? const AssetImage("assets/images/Beatdark.png")
                  : const AssetImage("assets/images/Beat.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height / 3.5,
                child: const SpinKitWave(
                  color: Color(0xff2962FF),
                ),
              ),
            ],
          )),
    );
  }

  void appPremission() async {
    var checkprimission = Hive.box("prmission");
    while (checkprimission.get("check") == false ||
        checkprimission.get("check") == null) {
      await AppPremission.getprimission();
      if (checkprimission.get("check") == true) {
        initapp();
      } else {}
    }
    if (checkprimission.get("check") == true) {
      initapp();
    } else {}
  }

  void initapp() {
    BlocProvider.of<AllSongsBloc>(context).add(AllSongsEvent());
    BlocProvider.of<PlayerBloc>(context)
        .add(InitHivePlayerEnent(box.get("mode") ?? "file"));
    BlocProvider.of<DirectoryListBloc>(context).add(LoadDirectoryListEvent());
    BlocProvider.of<ArtistBloc>(context).add(ArtistEvent());
    BlocProvider.of<AlbumBloc>(context).add(AlbumEvent());
    BlocProvider.of<PlaylistBloc>(context).add(PlaylistEvent());
    BlocProvider.of<FavoritSongBloc>(context).add(FavoriteSongeEvent());
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.pushReplacementNamed(context, '/home');
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) {
      //     return const HomeScreens();
      //   },
      // ));
    });
  }
}

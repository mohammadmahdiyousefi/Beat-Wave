import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/player/player_bloc.dart';
import 'package:justaudioplayer/bloc/player/player_event.dart';
import 'package:justaudioplayer/view/directory_list.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/widget/song%20_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NetworkStreamScreen extends StatefulWidget {
  NetworkStreamScreen({super.key});

  @override
  State<NetworkStreamScreen> createState() => _NetworkStreamScreenState();
}

class _NetworkStreamScreenState extends State<NetworkStreamScreen> {
  TextEditingController url = TextEditingController();

  final networkbox = Hive.box('NetworkSonglist');

  List<SongModel> songlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadnetworkSongList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Network Stream",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body:
          //  Center(
          //   child: Text(
          //     "next update",
          //     style: Theme.of(context).textTheme.displayLarge,
          //   ),
          // )
          //
          Column(children: [
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).cardColor,
          child: Container(
            height: height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.9,
                  child: TextFormField(
                    controller: url,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter the URL",
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<PlayerBloc>(context)
                        .add(InitNetworkPlayerEnent(url.text, "Network"));
                  },
                  child: Container(
                    height: 35,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Play ",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Theme.of(context).cardColor,
          child: Container(
            height: height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: networkbox.listenable(),
                      builder: (context, value, child) {
                        loadnetworkSongList();
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.values.length,
                          itemBuilder: (context, index) {
                            return SongTile(
                              index,
                              "network",
                              songlist,
                            );
                          },
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<PlayerBloc>(context)
                        .add(InitPlayerEnent(songlist, 0, "network"));
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).add(StartPlayerEnent());
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).player.setShuffleModeEnabled(false);
                  },
                  child: Container(
                    height: 35,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Play All ",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        Miniplayer(),
      ]),
    );
  }

  Future<List<SongModel>> loadnetworkSongList() async {
    songlist.clear();
    for (var song in networkbox.values.toList()) {
      SongModel audio = SongModel(song);
      songlist.add(audio);
    }

    return [];
  }
}

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/player/player.bloc.dart';
import '../bloc/player/player_event.dart';

import '../widget/artwork_widget.dart';
import '../widget/song _tile.dart';
import 'miniplayer.dart';

// ignore: must_be_immutable
class SongListScreen extends StatelessWidget {
  SongListScreen(
    this.directoryname,
    this.numberofsong, {
    super.key,
    this.id,
    this.type,
    this.nullartwork,
  });
  String directoryname;
  var controller = DraggableScrollableController();
  ScrollController scrollcontroller = ScrollController();
  Random random = Random();
  int? id;
  ArtworkType? type;
  String? nullartwork;
  int numberofsong;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: BlocBuilder<SongBloc, ISongListState>(
                builder: (context, state) {
              if (state is SongListState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          if (id == null) ...{
                            const Icon(
                              Icons.folder,
                              color: Color.fromARGB(255, 147, 147, 147),
                              size: 130,
                            )
                          } else ...{
                            ArtworkSong(
                              id: id!,
                              height: 130,
                              width: 130,
                              size: 300,
                              quality: 30,
                              type: type!,
                              nullartwork: nullartwork!,
                              radius: 20,
                            ),
                          },
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(directoryname.split("/").last,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white, fontSize: 30)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text("$numberofsong songs",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        color: Colors.grey.shade700,
                                        fontSize: 15))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xff212121),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PlayerBloc>(context).add(
                                    InitPlayerEnent(
                                        state.songs, 0, directoryname));
                                BlocProvider.of<PlayerBloc>(
                                  context,
                                ).add(StartPlayerEnent());
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color(0xff2962FF),
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
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PlayerBloc>(context).add(
                                    InitPlayerEnent(
                                        state.songs,
                                        random.nextInt(state.songs.length),
                                        directoryname));
                                BlocProvider.of<PlayerBloc>(
                                  context,
                                ).add(ShufflePlayerEnent());
                                BlocProvider.of<PlayerBloc>(
                                  context,
                                ).add(StartPlayerEnent());
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(0, 41, 98, 255),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Shuffle ",
                                      style: GoogleFonts.roboto(
                                          color: Color.fromARGB(
                                              255, 121, 121, 121),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Icon(
                                      Icons.shuffle,
                                      color: Color.fromARGB(255, 121, 121, 121),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AnimationLimiter(
                        child: CupertinoScrollbar(
                          thumbVisibility: true,
                          thickness: 9,
                          thicknessWhileDragging: 12,
                          controller: scrollcontroller,
                          radius: const Radius.circular(10),
                          child: ListView.builder(
                            controller: scrollcontroller,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.songs.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: SongTile(
                                        index, directoryname, state.songs),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
          Miniplayer(),
        ]),
      ),
      // floatingActionButton: const Miniplayer(),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  String timech(Duration duration) {
    String twoDigitMinutes =
        (duration.inMinutes % 60).toString().padLeft(2, '0');
    String twoDigitSeconds =
        (duration.inSeconds % 60).toString().padLeft(2, '0');
    if (duration.inHours != 0) {
      String time = '${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds';
      return time;
    } else {
      String time = '$twoDigitMinutes:$twoDigitSeconds';
      return time;
    }
  }

  String formatBytes(int bytes, int decimals) {
    if (bytes == 0) return "0 B";
    const k = 1024;
    final dm = decimals < 0 ? 0 : decimals;
    final sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(k)).floor();
    return '${(bytes / pow(k, i)).toStringAsFixed(dm)} ${sizes[i]}';
  }
}

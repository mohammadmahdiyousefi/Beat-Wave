import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:justaudioplayer/widget/play_shuffel_button.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
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
                              height: height * 0.18,
                              width: height * 0.18,
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
                                directoryname.split("/").last.length > 10
                                    ? SizedBox(
                                        height: 35,
                                        width: double.infinity,
                                        child: Marquee(
                                          text: directoryname.split("/").last,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          blankSpace: 60.0,
                                          velocity: 50.0,
                                          startAfter:
                                              const Duration(seconds: 3),
                                          pauseAfterRound:
                                              const Duration(seconds: 3),
                                          startPadding: 10.0,
                                          accelerationDuration:
                                              const Duration(seconds: 2),
                                          accelerationCurve: Curves.linear,
                                          decelerationDuration:
                                              const Duration(seconds: 1),
                                          decelerationCurve: Curves.easeOut,
                                        ),
                                      )
                                    : Text(directoryname.split("/").last,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text("${state.songs.length} songs",
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelMedium)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    PlaySuffelbutton(directoryname, state.songs),
                    Expanded(
                      child: AnimationLimiter(
                        child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 6,
                          interactive: true,
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
                                      index,
                                      directoryname,
                                      state.songs,
                                    ),
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

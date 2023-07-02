import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/consts/color.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/player/player.bloc.dart';
import '../bloc/player/player_event.dart';
import '../bloc/player/player_state.dart';
import 'artwork_widget.dart';

// ignore: must_be_immutable
class SongTile extends StatelessWidget {
  SongTile(this.index, this.path, this.songs, {super.key});
  List<SongModel> songs;
  int index;
  String path;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        BlocProvider.of<PlayerBloc>(context)
            .add(InitPlayerEnent(songs, index, path));
        BlocProvider.of<PlayerBloc>(
          context,
        ).add(StartPlayerEnent());
      },
      child: Container(
        height: 53,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.transparent),
        child: Row(
          children: [
            Stack(
              children: [
                ArtworkSong(
                  id: songs[index].id,
                  height: 53,
                  width: 53,
                  quality: 30,
                  size: 200,
                  type: ArtworkType.AUDIO,
                  nullartwork: "assets/images/cover.jpg",
                  radius: 8,
                ),
                Positioned(
                  bottom: 2,
                  right: 4,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color.fromARGB(187, 0, 0, 0),
                    ),
                    child: Center(
                      child: Text(
                        timech(Duration(milliseconds: songs[index].duration!)),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(songs[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 12)
                          // TextStyle(
                          //     color:
                          //         // path ==
                          //         //             songs[index].data.substring(
                          //         //                 0,
                          //         //                 songs[index]
                          //         //                     .data
                          //         //                     .lastIndexOf("/")) &&
                          //         //         index ==

                          //         //     ? CustomColor.customblue
                          //         Colors.white,
                          //     fontSize: 13),
                          ),
                      Text(songs[index].artist ?? "unkown",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                Visibility(
                    visible: path == songs[index].data ? true : false,
                    child: const Icon(
                      Icons.bar_chart,
                      color: CustomColor.customblue,
                    ))
              ],
            )),
            SongeMore(songs[index])
          ],
        ),
      ),
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
}

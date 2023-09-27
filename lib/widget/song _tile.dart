import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:justaudioplayer/widget/songnetwork_more.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/player/player_bloc.dart';
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<PlayerBloc, IPlayerState>(builder: (context, state) {
      if (state is PlayAudioState) {
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
            height: height * 0.075,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent),
            child: Row(
              children: [
                Stack(
                  children: [
                    path == "Network"
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: songs[index].data,
                              imageBuilder: (context, imageProvider) {
                                return SizedBox(
                                  height: height * 0.07,
                                  width: height * 0.07,
                                  child: Image(image: imageProvider),
                                );
                              },
                              placeholder: (context, url) {
                                return SizedBox(
                                  height: height * 0.07,
                                  width: height * 0.07,
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/images/cover.jpg")),
                                );
                              },
                            ),
                          )
                        : ArtworkSong(
                            id: songs[index].id,
                            height: height * 0.07,
                            width: height * 0.07,
                            quality: 30,
                            size: 200,
                            type: ArtworkType.AUDIO,
                            nullartwork: "assets/images/cover.jpg",
                            radius: 8,
                          ),
                    Positioned(
                      bottom: 2,
                      right: 4,
                      left: 4,
                      child: Container(
                        height: height * 0.025,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(187, 0, 0, 0),
                        ),
                        child: Center(
                          child: Text(
                            timech(
                                Duration(milliseconds: songs[index].duration!)),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.05,
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
                              style: state.song.data == songs[index].data
                                  ? Theme.of(context).textTheme.bodyMedium
                                  : Theme.of(context).textTheme.displayMedium),
                          Text(songs[index].artist ?? "unkown",
                              overflow: TextOverflow.ellipsis,
                              style: state.song.data == songs[index].data
                                  ? Theme.of(context).textTheme.bodySmall
                                  : Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                    ),
                    Visibility(
                        visible:
                            state.song.data == songs[index].data ? true : false,
                        child: Icon(
                          Icons.bar_chart,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                )),
                path == "Network"
                    ? SongenetworkMore(songs[index], index)
                    : SongeMore(songs[index], index),
              ],
            ),
          ),
        );
      } else {
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
            height: height * 0.075,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent),
            child: Row(
              children: [
                Stack(
                  children: [
                    path == "Network"
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: songs[index].data,
                              imageBuilder: (context, imageProvider) {
                                return SizedBox(
                                  height: height * 0.07,
                                  width: height * 0.07,
                                  child: Image(image: imageProvider),
                                );
                              },
                              placeholder: (context, url) {
                                return SizedBox(
                                  height: height * 0.07,
                                  width: height * 0.07,
                                  child: const Image(
                                      image: AssetImage(
                                          "assets/images/cover.jpg")),
                                );
                              },
                            ),
                          )
                        : ArtworkSong(
                            id: songs[index].id,
                            height: height * 0.07,
                            width: height * 0.07,
                            quality: 30,
                            size: 200,
                            type: ArtworkType.AUDIO,
                            nullartwork: "assets/images/cover.jpg",
                            radius: 8,
                          ),
                    Positioned(
                      bottom: 2,
                      right: 4,
                      left: 4,
                      child: Container(
                        height: height * 0.025,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(187, 0, 0, 0),
                        ),
                        child: Center(
                          child: Text(
                            timech(
                                Duration(milliseconds: songs[index].duration!)),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.05,
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
                              style: Theme.of(context).textTheme.displayMedium),
                          Text(songs[index].artist ?? "unkown",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                    ),
                  ],
                )),
                path == "Network"
                    ? SongenetworkMore(songs[index], index)
                    : SongeMore(songs[index], index),
              ],
            ),
          ),
        );
      }
    });
  }

  // SongModel song(String song) {
  //   dynamic decodedJson = jsonDecode(song);
  //   SongModel audio = SongModel(decodedJson);
  //   return audio;
  // }

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

import 'dart:convert';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/player/player_state.dart';
import 'package:justaudioplayer/view/play_music_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/player/player_bloc.dart';
import '../bloc/player/player_event.dart';
import '../widget/artwork_widget.dart';

// ignore: must_be_immutable
class Miniplayer extends StatelessWidget {
  Miniplayer({
    super.key,
  });

  final songlistbox = Hive.box('songlist');
  //final playermode = Hive.box('playmode');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, IPlayerState>(builder: (context, state) {
      if (state is PlayAudioState) {
        return GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              PageTransition(
                child: PlayMusicScreen(),
                type: PageTransitionType.bottomToTop,

                // alignment: Alignment.bottomCenter
              ),
            );
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Theme.of(context).primaryColorLight,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                // Colors.white12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: state.path == "Network"
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  imageUrl: state.song.data,
                                  // song(songlistbox.values
                                  //         .toList()[state.index])
                                  //     .data,
                                  imageBuilder: (context, imageProvider) {
                                    return SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: Image(
                                          fit: BoxFit.contain,
                                          image: imageProvider),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return const SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/cover.jpg")),
                                    );
                                  },
                                ),
                              )
                            : ArtworkSong(
                                id: state.song.id,
                                //  song(songlistbox.values
                                //         .toList()[state.index])
                                //     .id,
                                height: 45,
                                width: 45,
                                quality: 30,
                                size: 200,
                                type: ArtworkType.AUDIO,
                                nullartwork: "assets/images/cover.jpg",
                                radius: 6,
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.song.title,
                              // song(songlistbox.values
                              //         .toList()[state.index])
                              //     .title,
                              style: Theme.of(context).textTheme.displayMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.song.artist.toString(),
                              // song(songlistbox.values
                              //         .toList()[state.index])
                              //     .artist
                              //     .toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(PreviousPlayerEnent());
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(UpdatePlayerEnent());
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.skip_previous,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                )),
                            StreamBuilder<bool>(
                              stream: BlocProvider.of<PlayerBloc>(context)
                                  .player
                                  .playingStream,
                              initialData: BlocProvider.of<PlayerBloc>(context)
                                  .player
                                  .playing,
                              builder: (context, snapshot) {
                                final playing = snapshot.data;

                                return GestureDetector(
                                    onTap: () {
                                      if (playing == true) {
                                        BlocProvider.of<PlayerBloc>(context)
                                            .add(PausePlayerEnent());
                                      } else {
                                        BlocProvider.of<PlayerBloc>(context)
                                            .add(StartPlayerEnent());
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(
                                          playing == true
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ));
                              },
                            ),
                            GestureDetector(
                                onTap: () async {
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(NextPlayerEnent());
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(UpdatePlayerEnent());
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.skip_next,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Duration>(
                  stream: BlocProvider.of<PlayerBloc>(context)
                      .player
                      .positionStream,
                  builder: (context, progressSnapshot) {
                    final progress = progressSnapshot.data ?? Duration.zero;
                    if (state.index !=
                        BlocProvider.of<PlayerBloc>(context)
                            .player
                            .currentIndex) {
                      BlocProvider.of<PlayerBloc>(context)
                          .add(UpdatePlayerEnent());
                    }
                    return StreamBuilder<Duration?>(
                      stream: BlocProvider.of<PlayerBloc>(context)
                          .player
                          .durationStream,
                      builder: (context, totalSnapshot) {
                        final total = totalSnapshot.data ?? Duration.zero;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ProgressBar(
                            progress: progress,
                            thumbRadius: 0,
                            total: total,
                            barHeight: 1,
                            thumbCanPaintOutsideBar: false,
                            timeLabelLocation: TimeLabelLocation.none,
                            timeLabelTextStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            baseBarColor: Colors.transparent,
                            progressBarColor: Theme.of(context).primaryColor,
                            thumbColor: Colors.transparent,
                            onSeek: (value) async {
                              BlocProvider.of<PlayerBloc>(context)
                                  .add(SeekPlayerEnent(value));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ]),
            ),
          ),
        );
      } else if (state is LoadAudioState) {
        return const CircularProgressIndicator();
      } else if (state is ErrorAudioState) {
        return const Center(
          child: Text("error"),
        );
      } else {
        return Container();
      }
    });
  }

  // SongModel song(String song) {
  //   dynamic decodedJson = jsonDecode(song);
  //   SongModel audio = SongModel(decodedJson);
  //   return audio;
  // }
}

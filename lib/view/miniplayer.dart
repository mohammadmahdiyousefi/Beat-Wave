import 'dart:convert';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/player/player_state.dart';
import 'package:justaudioplayer/view/play_music_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/player/player.bloc.dart';
import '../bloc/player/player_event.dart';
import '../widget/artwork_widget.dart';

// ignore: must_be_immutable
class Miniplayer extends StatelessWidget {
  Miniplayer({
    super.key,
  });

  final songlistbox = Hive.box('songlist');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: songlistbox.listenable(),
        builder: (context, value, child) {
          return Visibility(
            visible: songlistbox.values.isEmpty ? false : true,
            child: BlocBuilder<PlayerBloc, IPlayerState>(
                builder: (context, state) {
              if (state is PlayAudioState) {
                return GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: PlayMusicScreen(songlistbox),
                        type: PageTransitionType.bottomToTop,

                        // alignment: Alignment.bottomCenter
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // gradient: const LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //     transform: GradientRotation(30),
                      //     colors: [
                      //       Color.fromARGB(143, 0, 54, 250),
                      //       Color.fromARGB(255, 55, 55, 59)
                      //     ]),
                      color: const Color(0xff1F1F1F),
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
                              child: ArtworkSong(
                                id: song(songlistbox.values
                                        .toList()[state.index])
                                    .id,
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
                                    song(songlistbox.values
                                            .toList()[state.index])
                                        .title,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 10,
                                        textStyle: const TextStyle(
                                            overflow: TextOverflow.ellipsis)),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    song(songlistbox.values
                                            .toList()[state.index])
                                        .artist
                                        .toString(),
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        BlocProvider.of<PlayerBloc>(context)
                                            .add(PreviousPlayerEnent());
                                        BlocProvider.of<PlayerBloc>(context)
                                            .add(UpdatePlayerEnent());
                                      },
                                      child: const Center(
                                        child: Icon(
                                          Icons.skip_previous,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      )),
                                  StreamBuilder<bool>(
                                    stream: BlocProvider.of<PlayerBloc>(context)
                                        .player
                                        .playingStream,
                                    initialData:
                                        BlocProvider.of<PlayerBloc>(context)
                                            .player
                                            .playing,
                                    builder: (context, snapshot) {
                                      final playing = snapshot.data;

                                      return GestureDetector(
                                          onTap: () {
                                            if (playing == true) {
                                              BlocProvider.of<PlayerBloc>(
                                                      context)
                                                  .add(PausePlayerEnent());
                                            } else {
                                              BlocProvider.of<PlayerBloc>(
                                                      context)
                                                  .add(StartPlayerEnent());
                                            }
                                          },
                                          child: Center(
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff2962FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                      child: const Center(
                                        child: Icon(
                                          Icons.skip_next,
                                          color: Colors.white,
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
                          final progress =
                              progressSnapshot.data ?? Duration.zero;
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: ProgressBar(
                                  progress: progress,
                                  thumbRadius: 0,
                                  total: total,
                                  barHeight: 1,
                                  thumbCanPaintOutsideBar: false,
                                  timeLabelLocation: TimeLabelLocation.none,
                                  timeLabelTextStyle:
                                      const TextStyle(color: Colors.white),
                                  baseBarColor: Colors.transparent,
                                  progressBarColor: Colors.white,
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
                );
              } else {
                return Container();
              }
            }),
          );
        });
  }

  SongModel song(String song) {
    dynamic decodedJson = jsonDecode(song);
    SongModel audio = SongModel(decodedJson);
    return audio;
  }
}

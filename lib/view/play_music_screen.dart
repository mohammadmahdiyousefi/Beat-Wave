import 'dart:async';
import 'dart:convert';

import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_bloc.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_event.dart';
import 'package:justaudioplayer/bloc/player/player.bloc.dart';
import 'package:justaudioplayer/bloc/player/player_event.dart';
import 'package:justaudioplayer/bloc/player/player_state.dart';
import 'package:justaudioplayer/widget/artwork_widget.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/playlist/playlist_bloc.dart';
import '../bloc/playlist/playlist_event.dart';
import '../widget/add_to_playlist.dart';
import '../widget/song_info_widget.dart';

// ignore: must_be_immutable
class PlayMusicScreen extends StatelessWidget {
  PlayMusicScreen(this.box, {super.key});
  Box<dynamic> box;
  // final box = Hive.box('songlist');
  final favoritebox = Hive.box('FavoriteSongs');

  SongModel song(String song) {
    dynamic decodedJson = jsonDecode(song);
    SongModel audio = SongModel(decodedJson);
    return audio;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 30, 30, 30),
            Color.fromARGB(255, 25, 25, 25),
            Color.fromARGB(255, 20, 20, 20),
            Color.fromARGB(255, 15, 15, 15),
            Color.fromARGB(255, 10, 10, 10),
            Color.fromARGB(255, 5, 5, 5),
            Color.fromARGB(255, 0, 0, 0)
          ])),
      child: Scaffold(
        backgroundColor: const Color(0xff121212),
        //Color.fromARGB(255, 1, 1, 18),
        body: BlocBuilder<PlayerBloc, IPlayerState>(builder: (context, state) {
          if (state is PlayAudioState) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
//------------------------------------------------------------------------------
                  // custom  App bar //
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await Share.shareXFiles([
                              XFile(song(box.values.toList()[state.index]).data)
                            ],
                                text: song(box.values.toList()[state.index])
                                    .displayName);
                          },
                          child: const Icon(
                            Icons.share_sharp,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        menu(context, song(box.values.toList()[state.index])),
                      ],
                    ),
                  ),

                  //custom App BAr//
//------------------------------------------------------------------------------
                  const Spacer(),
//------------------------------------------------------------------------------
                  //  music ArtWork //
                  ArtworkSong(
                    id: song(box.values.toList()[state.index]).id,
                    height: height * 0.43,
                    width: height * 0.43,
                    size: 1000,
                    quality: 100,
                    radius: 20,
                    artworkQuality: FilterQuality.high,
                  ),
                  //  music ArtWork //
//------------------------------------------------------------------------------
                  SizedBox(
                    height: height * 0.02,
                  ),
//------------------------------------------------------------------------------
                  // music displayName //
                  SizedBox(
                    height: height * 0.06,
                    width: width * 0.45,
                    child: Marquee(
                      text: song(box.values.toList()[state.index])
                          .displayNameWOExt,
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.w600),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 60.0,
                      velocity: 80.0,
                      startAfter: const Duration(seconds: 2),
                      pauseAfterRound: const Duration(seconds: 2),
                      startPadding: 10.0,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(seconds: 1),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  // music displayName //
//------------------------------------------------------------------------------
                  // music title //
                  SizedBox(
                    height: height * 0.03,
                    width: width * 0.60,
                    child: Marquee(
                      text: song(box.values.toList()[state.index]).title,
                      style: GoogleFonts.roboto(
                          color: Colors.grey, fontSize: height * 0.015),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 60.0,
                      velocity: 50.0,
                      startAfter: const Duration(seconds: 3),
                      pauseAfterRound: const Duration(seconds: 3),
                      startPadding: 10.0,
                      accelerationDuration: const Duration(seconds: 2),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(seconds: 1),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  // music title //
//------------------------------------------------------------------------------
                  // music player handeler //
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                    child: Column(
                      children: [
//------------------------------------------------------------------------------
                        // Like playlist mute button //
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: height * 0.02, top: height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StreamBuilder<double>(
                                  stream: BlocProvider.of<PlayerBloc>(context)
                                      .player
                                      .volumeStream,
                                  builder: (context, snapshot) {
                                    final double volum = snapshot.data ?? 0;
                                    return GestureDetector(
                                      onTap: () {
                                        if (volum == 1) {
                                          BlocProvider.of<PlayerBloc>(context)
                                              .add(VolumPlayerEnent(0));
                                        } else {
                                          BlocProvider.of<PlayerBloc>(context)
                                              .add(VolumPlayerEnent(1));
                                        }
                                      },
                                      child: Icon(
                                        volum == 0
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: Colors.white,
                                      ),
                                    );
                                  }),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PlaylistBloc>(context)
                                      .add(PlaylistEvent());
                                  bottomshet(context,
                                      song(box.values.toList()[state.index]));
                                },
                                child: const Icon(
                                  Icons.person_add_alt_1,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              ValueListenableBuilder(
                                  valueListenable: favoritebox.listenable(),
                                  builder: (context, value, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (favoritebox.values
                                            .toList()
                                            .contains(box.values
                                                .toList()[state.index])) {
                                          BlocProvider.of<FavoritSongBloc>(
                                                  context)
                                              .add(DeleteFavoriteSongeEvent(box
                                                  .values
                                                  .toList()[state.index]));
                                        } else {
                                          BlocProvider.of<FavoritSongBloc>(
                                                  context)
                                              .add(AddFavoriteSongeEvent(box
                                                  .values
                                                  .toList()[state.index]));
                                        }
                                      },
                                      child: Icon(
                                        favoritebox.values.toList().contains(box
                                                    .values
                                                    .toList()[state.index]) ==
                                                true
                                            ? Icons.favorite_sharp
                                            : Icons.favorite_outline,
                                        color: favoritebox.values
                                                    .toList()
                                                    .contains(
                                                        box.values.toList()[
                                                            state.index]) ==
                                                true
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                        // Like playlist mute button //
//------------------------------------------------------------------------------
                        //  muzic progress bar //
                        StreamBuilder<Duration>(
                          stream: BlocProvider.of<PlayerBloc>(context)
                              .player
                              .positionStream,
                          initialData: BlocProvider.of<PlayerBloc>(context)
                              .player
                              .position,
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
                            return StreamBuilder<Duration>(
                              stream: BlocProvider.of<PlayerBloc>(context)
                                  .player
                                  .bufferedPositionStream,
                              initialData: BlocProvider.of<PlayerBloc>(context)
                                  .player
                                  .bufferedPosition,
                              builder: (context, bufferedSnapshot) {
                                final buffered =
                                    bufferedSnapshot.data ?? Duration.zero;

                                return StreamBuilder<Duration?>(
                                  stream: BlocProvider.of<PlayerBloc>(context)
                                      .player
                                      .durationStream,
                                  initialData:
                                      BlocProvider.of<PlayerBloc>(context)
                                          .player
                                          .duration,
                                  builder: (context, totalSnapshot) {
                                    final total =
                                        totalSnapshot.data ?? Duration.zero;

                                    return ProgressBar(
                                      progress: progress,
                                      buffered: buffered,
                                      total: total,
                                      timeLabelTextStyle:
                                          const TextStyle(color: Colors.white),
                                      baseBarColor:
                                          const Color.fromARGB(255, 54, 54, 54),
                                      bufferedBarColor: const Color.fromARGB(
                                          99, 215, 215, 215),
                                      progressBarColor: Colors.white,
                                      thumbColor: Colors.white,
                                      onSeek: (value) async {
                                        BlocProvider.of<PlayerBloc>(context)
                                            .add(SeekPlayerEnent(value));
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        //  muzic progress bar //
//------------------------------------------------------------------------------
                        SizedBox(
                          height: height * 0.02,
                        ),
//------------------------------------------------------------------------------
                        // play pause next previus button //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PlayerBloc>(context).add(
                                      SeekPlayerEnent(Duration(
                                          seconds: BlocProvider.of<PlayerBloc>(
                                                      context)
                                                  .player
                                                  .position
                                                  .inSeconds -
                                              10)));
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.fast_rewind,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
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
                                    size: 40,
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
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: Center(
                                      child: Icon(
                                        playing == true
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 35,
                                        color: Colors.black,
                                      ),
                                      // )
                                    ),
                                  ),
                                );
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
                                    size: 40,
                                  ),
                                )),
                            GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PlayerBloc>(context).add(
                                      SeekPlayerEnent(Duration(
                                          seconds: BlocProvider.of<PlayerBloc>(
                                                      context)
                                                  .player
                                                  .position
                                                  .inSeconds +
                                              10)));
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.fast_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                          ],
                        ),
                        // play pause next previus button //
//------------------------------------------------------------------------------
                        // shufel loop speed button //
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PlayerBloc>(context)
                                        .add(ShufflePlayerEnent());
                                  },
                                  child: Center(
                                    child: StreamBuilder<bool>(
                                        stream:
                                            BlocProvider.of<PlayerBloc>(context)
                                                .player
                                                .shuffleModeEnabledStream,
                                        initialData:
                                            BlocProvider.of<PlayerBloc>(context)
                                                .player
                                                .shuffleModeEnabled,
                                        builder: (context, snapshot) {
                                          final shuffel = snapshot.data;
                                          return Icon(
                                            Icons.shuffle,
                                            color: shuffel == true
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 97, 97, 97),
                                            size: 25,
                                          );
                                        }),
                                  )),
                              GestureDetector(
                                  onTap: () async {
                                    await opendiolog(context);
                                  },
                                  child: StreamBuilder<double>(
                                      stream:
                                          BlocProvider.of<PlayerBloc>(context)
                                              .player
                                              .speedStream,
                                      builder: (context, snapshot) {
                                        final speed = snapshot.data ?? 1.0;
                                        return Center(
                                            child: Text(
                                          "${speed.toStringAsFixed(2)}x",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ));
                                      })),
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PlayerBloc>(context)
                                        .add(LoopPlayerEnent());
                                  },
                                  child: Center(
                                    child: StreamBuilder<LoopMode>(
                                        stream:
                                            BlocProvider.of<PlayerBloc>(context)
                                                .player
                                                .loopModeStream,
                                        initialData:
                                            BlocProvider.of<PlayerBloc>(context)
                                                .player
                                                .loopMode,
                                        builder: (context, snapshot) {
                                          final loop = snapshot.data;
                                          return Icon(
                                            loop == LoopMode.all
                                                ? Icons.repeat_one_rounded
                                                : Icons.repeat,
                                            color: loop == LoopMode.off
                                                ? const Color.fromARGB(
                                                    255, 97, 97, 97)
                                                : Colors.white,
                                            size: 25,
                                          );
                                        }),
                                  )),
                            ],
                          ),
                        ),
                        // shufel loop speed button //
//------------------------------------------------------------------------------
                      ],
                    ),
                  ),
                  // music player handeler //
//------------------------------------------------------------------------------
                  SizedBox(
                    height: height * 0.03,
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }

  Widget menu(BuildContext context, SongModel song) {
    return PopupMenuButton(
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color.fromARGB(255, 43, 43, 43),
        splashRadius: 23.5,
        elevation: 0,
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 25,
        ),
        onSelected: (value) {
          // your logic
          if (value == '/Song Info') {
            songInfo(context, song);
          }
        },
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem(
              // ignore: sort_child_properties_last
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Song Info",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: '/Song Info',
            ),
          ];
        });
  }

  Future opendiolog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(
              child: Text(
            'Adjust Speed',
          )),
          backgroundColor: Color.fromARGB(255, 22, 22, 22),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          content: SizedBox(
            height: 111,
            width: 100,
            child: StreamBuilder<double>(
                stream: BlocProvider.of<PlayerBloc>(context).player.speedStream,
                builder: (context, snapshot) {
                  final speed = snapshot.data ?? 1.0;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(SpeedPlayerEnent(speed - 0.05));
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                            Text(
                              "${speed.toStringAsFixed(2)}x",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  BlocProvider.of<PlayerBloc>(context)
                                      .add(SpeedPlayerEnent(speed + 0.05));
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: Slider(
                          max: 4,
                          min: 0.25,
                          divisions: 10,
                          value: speed,
                          inactiveColor: Colors.black,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            BlocProvider.of<PlayerBloc>(context)
                                .add(SpeedPlayerEnent(value));
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                BlocProvider.of<PlayerBloc>(context)
                                    .add(SpeedPlayerEnent(1.0));
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 25,
                          )
                        ],
                      )
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}

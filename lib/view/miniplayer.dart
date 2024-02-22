import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:justaudioplayer/data/model/positiondata.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/view/play_music_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class Miniplayer extends StatelessWidget {
  Miniplayer({super.key});
  final AudioPlayer _player = locator.get<AudioPlayer>();
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();

  /// We combine 3 streams here. The first stream is the position of the
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
        stream: _player.sequenceStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final SequenceState? sequenceState = snapshot.data;
            final SongModel info =
                SongModel(sequenceState!.currentSource?.tag.extras ?? {});
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      transitionDuration: const Duration(milliseconds: 360),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 360),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          PlayMusicScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        final tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
//--------------------------- song Artwork -------------------------------------
                          QueryArtworkWidget(
                            id: info.id,
                            quality: 50,
                            size: 200,
                            format: ArtworkFormat.JPEG,
                            controller: onAudioQuery,
                            type: ArtworkType.AUDIO,
                            keepOldArtwork: false,
                            artworkBorder: BorderRadius.circular(6),
                            artworkQuality: FilterQuality.low,
                            artworkFit: BoxFit.fill,
                            artworkHeight: 50,
                            artworkWidth: 50,
                            nullArtworkWidget: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/cover.jpg",
                                    ),
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.cover),
                                color: const Color.fromARGB(255, 61, 60, 60),
                              ),
                            ),
                          ),
//--------------------------- song Artwork -------------------------------------
//------------------------------------------------------------------------------
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
//-------------------- song displayNameWOExt and artist name -------------------
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              info.title,
                                              style: Theme.of(context)
                                                  .listTileTheme
                                                  .titleTextStyle!
                                                  .copyWith(
                                                      color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              info.artist ?? "<unknown>",
                                              style: Theme.of(context)
                                                  .listTileTheme
                                                  .subtitleTextStyle,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
//-------------------- song displayNameWOExt and artist name -------------------
                                      const SizedBox(
                                        width: 7,
                                      ),
//-------------------- song controler play next and Previous bottun-------------
                                      _previousButton(),
                                      StreamBuilder<PlayerState>(
                                        stream: _player.playerStateStream,
                                        builder: (context, snapshot) {
                                          final PlayerState? playerState =
                                              snapshot.data;
                                          return _playerButton(playerState);
                                        },
                                      ),
                                      _nextButton()
                                    ],
                                  ),

//-------------------- song controler play next and Previous bottun-------------
//------------------------------------------------------------------------------
                                  //----------------------------- song progress bar ------------------------------
                                  StreamBuilder<PositionData>(
                                      stream: _positionDataStream,
                                      initialData: PositionData(
                                          _player.position,
                                          _player.bufferedPosition,
                                          _player.duration ?? Duration.zero),
                                      builder: (context, snapshot) {
                                        final positionData = snapshot.data;
                                        return ProgressBar(
                                          progress: positionData?.position ??
                                              Duration.zero,
                                          thumbRadius: 0,
                                          total: positionData?.duration ??
                                              Duration.zero,
                                          barHeight: 3,
                                          thumbGlowRadius: 8,
                                          thumbCanPaintOutsideBar: false,
                                          timeLabelLocation:
                                              TimeLabelLocation.none,
                                          baseBarColor: Theme.of(context)
                                              .sliderTheme
                                              .secondaryActiveTrackColor,
                                          progressBarColor: Theme.of(context)
                                              .sliderTheme
                                              .activeTrackColor,
                                          thumbColor: Colors.transparent,
                                          onSeek: (value) {
                                            _player.seek(value);
                                          },
                                        );
                                      })
//----------------------------- song progress bar ------------------------------
//------------------------------------------------------------------------------
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _playerButton(PlayerState? playerState) {
    final ProcessingState processingState =
        playerState?.processingState ?? ProcessingState.loading;
    final bool playing = playerState?.playing ?? false;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(0.0),
        width: 26.0,
        height: 26.0,
        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else if (playing != true) {
      return GestureDetector(
        child: const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 26,
        ),
        onTap: () {
          _player.play();
        },
      );
    } else if (processingState != ProcessingState.completed) {
      return GestureDetector(
        child: const Icon(
          Icons.pause,
          color: Colors.white,
          size: 26,
        ),
        onTap: () {
          _player.pause();
        },
      );
    } else {
      return GestureDetector(
        child: const Icon(
          Icons.replay,
          color: Colors.white,
          size: 26,
        ),
        onTap: () {
          _player.seek(Duration.zero);
        },
      );
    }
  }

  Widget _previousButton() {
    return _player.hasPrevious
        ? IconButton(
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 26,
            ),
            onPressed: _player.seekToPrevious,
          )
        : const SizedBox();
  }

  Widget _nextButton() {
    return _player.hasNext
        ? IconButton(
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 26,
            ),
            onPressed: _player.seekToNext,
          )
        : const SizedBox();
  }
}

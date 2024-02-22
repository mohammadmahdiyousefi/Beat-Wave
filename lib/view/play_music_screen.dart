import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/model/positiondata.dart';
import 'package:justaudioplayer/widget/add_to_playlist.dart';
import 'package:justaudioplayer/widget/favorit_button.dart';
import 'package:justaudioplayer/widget/song_info_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart';

class PlayMusicScreen extends StatelessWidget {
  PlayMusicScreen({super.key});
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      body: StreamBuilder<SequenceState?>(
        stream: _player.sequenceStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final SequenceState? sequenceState = snapshot.data;
            final SongModel info =
                SongModel(sequenceState!.currentSource?.tag.extras ?? {});
            return ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15,
                  sigmaY: 15,
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
//------------------------------------------------------------------------------
                      // custom  App bar //
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 12,
                          right: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 30,
                                )),
                            Container(
                              width: 85,
                              height: 2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            IconButton(
                              onPressed: () async {
                                await _moreBottomSheet(context, info);
                              },
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      //custom App BAr//
//------------------------------------------------------------------------------
                      //  music ArtWork //
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.09),
                          child: QueryArtworkWidget(
                            id: info.id,
                            quality: 60,
                            size: 600,
                            format: ArtworkFormat.JPEG,
                            controller: onAudioQuery,
                            type: ArtworkType.AUDIO,
                            keepOldArtwork: true,
                            artworkBorder: BorderRadius.circular(16),
                            artworkQuality: FilterQuality.low,
                            artworkFit: BoxFit.fill,
                            artworkHeight: double.infinity,
                            artworkWidth: double.infinity,
                            nullArtworkWidget: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
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
                        ),
                      ),
                      //  music ArtWork //
//------------------------------------------------------------------------------
                      // music displayName //
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    info.title,
                                    style: Theme.of(context)
                                        .listTileTheme
                                        .titleTextStyle!
                                        .copyWith(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  //------------------------------------------------------------------------------
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
                            const SizedBox(
                              width: 6,
                            ),
                            StreamBuilder<bool>(
                              stream: _player.shuffleModeEnabledStream,
                              initialData: _player.shuffleModeEnabled,
                              builder: (context, snapshot) {
                                return _shuffleButton(
                                    context, snapshot.data ?? false);
                              },
                            ),
                          ],
                        ),
                      ),
//------------------------------------------------------------------------------
                      // music player handeler //
                      StreamBuilder<PositionData>(
                          stream: _positionDataStream,
                          initialData: PositionData(
                              _player.position,
                              _player.bufferedPosition,
                              _player.duration ?? Duration.zero),
                          builder: (context, snapshot) {
                            final PositionData? positionData = snapshot.data;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17),
                              child: ProgressBar(
                                progress:
                                    positionData?.position ?? Duration.zero,
                                total: positionData?.duration ??
                                    const Duration(minutes: 1),
                                buffered: positionData?.bufferedPosition ??
                                    Duration.zero,
                                bufferedBarColor: Theme.of(context)
                                    .sliderTheme
                                    .activeTrackColor!
                                    .withOpacity(0.3),
                                thumbRadius: 7,
                                barHeight: 4,
                                thumbGlowRadius: 8,
                                timeLabelPadding: 6,
                                thumbCanPaintOutsideBar: true,
                                timeLabelLocation: TimeLabelLocation.below,
                                timeLabelTextStyle: Theme.of(context)
                                    .sliderTheme
                                    .valueIndicatorTextStyle,
                                baseBarColor: Theme.of(context)
                                    .sliderTheme
                                    .secondaryActiveTrackColor,
                                progressBarColor: Theme.of(context)
                                    .sliderTheme
                                    .activeTrackColor,
                                thumbColor:
                                    Theme.of(context).sliderTheme.thumbColor,
                                onSeek: (value) {
                                  _player.seek(value);
                                },
                              ),
                            );
                          }),
                      //  muzic progress bar //
//------------------------------------------------------------------------------
                      const SizedBox(
                        height: 10,
                      ),
//------------------------------------------------------------------------------
                      // play pause next previus button //
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StreamBuilder<LoopMode>(
                              stream: _player.loopModeStream,
                              initialData: _player.loopMode,
                              builder: (context, snapshot) {
                                return _repeatButton(
                                    context, snapshot.data ?? LoopMode.off);
                              },
                            ),
                            _previousButton(),
                            StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              initialData: _player.playerState,
                              builder: (context, snapshot) {
                                final PlayerState? playerState = snapshot.data;
                                return Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: _playerButton(playerState));
                              },
                            ),
                            _nextButton(),
                            FavoritButton(
                              song: info,
                              size: 27,
                            )
                          ]),
//------------------------------------------------------------------------------
                      const SizedBox(
                        height: 34,
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<Widget?> _moreBottomSheet(
    BuildContext context,
    SongModel song,
  ) {
    final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
    final List<Widget> items = [
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/add-to-album-icon.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text(
          "Add to playlist",
        ),
        onTap: () async {
          Navigator.pop(context);
          await addtoplaylistbottomshet(context, song);
        },
      ),
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/share-icon.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text(
          "Share",
        ),
        onTap: () async {
          Navigator.pop(context);
          await Share.shareXFiles([XFile(song.data)],
              text: song.displayNameWOExt);
        },
      ),
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/Group 8.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color,
        ),
        title: const Text(
          "Properties",
        ),
        onTap: () async {
          Navigator.pop(context);
          await songInfoBottomSheet(context, song);
        },
      ),
    ];
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width -
              32, // here increase or decrease in width
          maxHeight: MediaQuery.of(context).size.height * 0.4),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: ListTile(
                shape: Theme.of(context).listTileTheme.shape,
                contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                title: Text(song.title),
                titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
                subtitle: Text(song.artist ?? "<unkown>"),
                subtitleTextStyle:
                    Theme.of(context).listTileTheme.subtitleTextStyle,
                trailing: FavoritButton(
                  song: song,
                  color: Theme.of(context).iconTheme.color ?? Colors.grey,
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/cover.jpg"))),
                  child: QueryArtworkWidget(
                    id: song.id,
                    quality: 50,
                    size: 200,
                    controller: onAudioQuery,
                    format: ArtworkFormat.JPEG,
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
                ),
              ),
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
              thickness: 1,
              height: 3,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) => items[index],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _playerButton(PlayerState? playerState) {
    final ProcessingState processingState =
        playerState?.processingState ?? ProcessingState.loading;
    final bool playing = playerState?.playing ?? false;

    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    } else if (playing != true) {
      return GestureDetector(
        child: const Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 30,
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
          size: 30,
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
          size: 30,
        ),
        onTap: () {
          _player.seek(Duration.zero);
        },
      );
    }
  }

  Widget _previousButton() {
    return IconButton(
      icon: const Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35,
      ),
      onPressed: _player.hasPrevious ? _player.seekToPrevious : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: const Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35,
      ),
      onPressed: _player.hasNext ? _player.seekToNext : null,
    );
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: Theme.of(context).primaryColor)
          : const Icon(
              Icons.shuffle,
              color: Colors.white,
            ),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await _player.shuffle();
        }
        await _player.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      const Icon(
        Icons.repeat,
        color: Colors.white,
        size: 26,
      ),
      Icon(Icons.repeat, color: Theme.of(context).primaryColor),
      Icon(Icons.repeat_one, color: Theme.of(context).primaryColor),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        _player.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}

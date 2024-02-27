import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/data/model/positiondata.dart';
import 'package:beat_wave/widget/add_to_playlist.dart';
import 'package:beat_wave/widget/favorit_button.dart';
import 'package:beat_wave/widget/song_info_widget.dart';
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
            final SequenceState sequenceState = snapshot.data!;
            final SongModel info = SongModel(
                sequenceState.currentSource?.tag.extras["SongModel"] ?? {});
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
                                  MediaQuery.of(context).size.height * 0.08),
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
                      ListTile(
                          horizontalTitleGap: 3,
                          title: Text(
                            info.title,
                            style: Theme.of(context)
                                .listTileTheme
                                .titleTextStyle!
                                .copyWith(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          titleTextStyle: Theme.of(context)
                              .listTileTheme
                              .titleTextStyle!
                              .copyWith(color: Colors.white),
                          subtitle: Text(
                            info.artist ?? "<unknown>",
                            style: Theme.of(context)
                                .listTileTheme
                                .subtitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitleTextStyle:
                              Theme.of(context).listTileTheme.subtitleTextStyle,
                          trailing: FavoritButton(
                            song: info,
                            color: Colors.white,
                            size: 26,
                          )),
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
                                thumbRadius: 8,
                                barHeight: 5,
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
                            StreamBuilder<bool>(
                              stream: _player.shuffleModeEnabledStream,
                              initialData: _player.shuffleModeEnabled,
                              builder: (context, snapshot) {
                                return _shuffleButton(
                                    context, snapshot.data ?? false);
                              },
                            ),
                            _previousButton(),
                            StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              initialData: _player.playerState,
                              builder: (context, snapshot) {
                                final PlayerState? playerState = snapshot.data;
                                return _playerButton(context, playerState);
                              },
                            ),
                            _nextButton(),
                            StreamBuilder<LoopMode>(
                              stream: _player.loopModeStream,
                              initialData: _player.loopMode,
                              builder: (context, snapshot) {
                                return _repeatButton(
                                    context, snapshot.data ?? LoopMode.off);
                              },
                            ),
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
    final BuildContext context,
    final SongModel song,
  ) {
    final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
    final List<Widget> items = [
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/add-to-album-icon.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color, height: 18,
          width: 18,
        ),
        title: Text(
          "Add to playlist",
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        onTap: () async {
          Navigator.pop(context);
          await addtoplaylistbottomshet(context, song);
        },
      ),
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/speedometer.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color,
          height: 18,
          width: 18,
        ),
        title: Text(
          "Play Speed",
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        onTap: () async {
          Navigator.pop(context);
          await _playSpeedBottomSheet(context);
        },
      ),
      ListTile(
        horizontalTitleGap: 6,
        leading: SvgPicture.asset(
          "assets/svg/share-icon.svg",
          // ignore: deprecated_member_use
          color: Theme.of(context).iconTheme.color, height: 18,
          width: 18,
        ),
        title: Text(
          "Share",
          style: Theme.of(context).listTileTheme.titleTextStyle,
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
          color: Theme.of(context).iconTheme.color, height: 18,
          width: 18,
        ),
        title: Text(
          "Properties",
          style: Theme.of(context).listTileTheme.titleTextStyle,
        ),
        onTap: () async {
          Navigator.pop(context);
          await songInfoBottomSheet(context, song);
        },
      ),
    ];
    return showModalBottomSheet(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                pinned: true,
                toolbarHeight: 80,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      shape: Theme.of(context).listTileTheme.shape,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                      title: Text(song.title),
                      titleTextStyle:
                          Theme.of(context).listTileTheme.titleTextStyle,
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
                    const Divider(
                      thickness: 1,
                      height: 3,
                    ),
                  ],
                ),
                scrolledUnderElevation: 0,
              ),
              SliverList.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => items[index],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Widget?> _playSpeedBottomSheet(
    final BuildContext context,
  ) {
    return showModalBottomSheet(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Play Speed",
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
              thickness: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<double>(
                stream: _player.speedStream,
                initialData: _player.speed,
                builder: (context, snapshot) {
                  final double? speed = snapshot.data;
                  return Column(
                    children: [
                      Text("Speed : ${speed?.toStringAsFixed(2) ?? "1.0"} x"),
                      Slider(
                        value: speed ?? 0.5,
                        min: 0.25,
                        max: 2,
                        onChanged: (value) {
                          _player.setSpeed(value);
                        },
                      ),
                    ],
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () => _player.setSpeed(0.25),
                    child: const Text("0.25x")),
                TextButton(
                    onPressed: () => _player.setSpeed(0.5),
                    child: const Text("0.5x")),
                TextButton(
                    onPressed: () => _player.setSpeed(1),
                    child: const Text("Normal")),
                TextButton(
                    onPressed: () => _player.setSpeed(1.5),
                    child: const Text("1.5x")),
                TextButton(
                    onPressed: () => _player.setSpeed(2),
                    child: const Text("2.0x")),
              ],
            ),
            const SizedBox(
              height: 16,
            )
          ],
        );
      },
    );
  }

  Widget _playerButton(
      final BuildContext context, final PlayerState? playerState) {
    final ProcessingState processingState =
        playerState?.processingState ?? ProcessingState.loading;
    final bool playing = playerState?.playing ?? false;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: (playing != true)
                ? IconButton(
                    padding: const EdgeInsets.only(left: 4),
                    icon: SvgPicture.asset(
                      "assets/svg/play.svg",
                      // ignore: deprecated_member_use
                      color: Colors.white,
                      height: 26,
                      width: 26,
                    ),
                    onPressed: () {
                      _player.play();
                    },
                  )
                : (processingState != ProcessingState.completed)
                    ? IconButton(
                        icon: SvgPicture.asset(
                          "assets/svg/pause.svg",
                          // ignore: deprecated_member_use
                          color: Colors.white,
                          height: 26,
                          width: 26,
                        ),
                        onPressed: () {
                          _player.pause();
                        },
                      )
                    : IconButton(
                        icon: SvgPicture.asset(
                          "assets/svg/replay.svg",
                          // ignore: deprecated_member_use
                          color: Colors.white,
                          height: 26,
                          width: 26,
                        ),
                        onPressed: () {
                          _player.seek(Duration.zero);
                        },
                      )),
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) ...{
          SizedBox(
            height: 62,
            width: 62,
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              strokeWidth: 4,
            ),
          )
        } else ...{
          const SizedBox(
            height: 62,
            width: 62,
          )
        }
      ],
    );
  }

  Widget _previousButton() {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: SvgPicture.asset(
        "assets/svg/previous.svg",
        // ignore: deprecated_member_use
        color: Colors.white,
        height: 32,
        width: 32,
      ),
      onPressed: _player.hasPrevious ? _player.seekToPrevious : null,
    );
  }

  Widget _nextButton() {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: SvgPicture.asset(
        "assets/svg/next.svg",
        // ignore: deprecated_member_use
        color: Colors.white,
        height: 32,
        width: 32,
      ),
      onPressed: _player.hasNext ? _player.seekToNext : null,
    );
  }

  Widget _shuffleButton(final BuildContext context, final bool isEnabled) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: SvgPicture.asset(
        "assets/svg/shuffle.svg",
        // ignore: deprecated_member_use
        color: isEnabled ? Theme.of(context).primaryColor : Colors.white,
        height: 22,
        width: 22,
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

  Widget _repeatButton(final BuildContext context, final LoopMode loopMode) {
    final icons = [
      SvgPicture.asset(
        "assets/svg/repeat.svg",
        // ignore: deprecated_member_use
        color: Colors.white,
        height: 36,
        width: 36,
      ),
      SvgPicture.asset(
        "assets/svg/repeat.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).primaryColor,
        height: 36,
        width: 36,
      ),
      SvgPicture.asset(
        "assets/svg/repeat-one.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).primaryColor,
        height: 36,
        width: 36,
      )
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: icons[index],
      onPressed: () {
        _player.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
    );
  }
}

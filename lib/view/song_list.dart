import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:justaudioplayer/data/model/player.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/widget/lodingwidget.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:justaudioplayer/widget/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'miniplayer.dart';

class SongListScreen extends StatelessWidget {
  SongListScreen(
      {super.key,
      required this.id,
      required this.nullArtwork,
      required this.title,
      required this.appbarTitle,
      required this.type,
      this.audiosFromType,
      this.path});
  final int id;
  final String nullArtwork;
  final String title;
  final String appbarTitle;
  final ArtworkType type;
  final AudiosFromType? audiosFromType;
  final String? path;
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var songBloc = SongBloc();
        songBloc.add(GetSongListEvent(id, audiosFromType, path));
        return songBloc;
      },
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: Miniplayer(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<SongBloc, SongListState>(
            builder: (context, state) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    titleTextStyle: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle!
                        .copyWith(color: Colors.white),
                    toolbarTextStyle: Theme.of(context).textTheme.bodySmall,
                    elevation: 3,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    collapsedHeight: MediaQuery.of(context).size.height * 0.4,
                    scrolledUnderElevation: 0,
                    expandedHeight: MediaQuery.of(context).size.height * 0.4,
                    pinned: true,
                    centerTitle: true,
                    title: Text(
                      appbarTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        foregroundDecoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xff000000).withOpacity(0.75),
                                  const Color(0xff000000).withOpacity(0)
                                ])),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          child: QueryArtworkWidget(
                            id: id,
                            quality: 60,
                            size: 600,
                            format: ArtworkFormat.JPEG,
                            controller: onAudioQuery,
                            type: type,
                            keepOldArtwork: true,
                            artworkBorder: BorderRadius.circular(0),
                            artworkQuality: FilterQuality.low,
                            artworkFit: BoxFit.fill,
                            artworkHeight: double.infinity,
                            artworkWidth: double.infinity,
                            nullArtworkWidget: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                image: DecorationImage(
                                    image: AssetImage(
                                      nullArtwork,
                                    ),
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.cover),
                                color: const Color.fromARGB(255, 61, 60, 60),
                              ),
                            ),
                          ),
                        ),
                      ),
                      titlePadding:
                          const EdgeInsets.only(bottom: 8, left: 16, right: 8),
                      centerTitle: false,
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          if (state is SongList) ...{
                            _playandshuffle(state.songs)
                          } else ...{
                            _playandshuffle([])
                          }
                        ],
                      ),
                    ),
                  ),
                  if (state is SongList) ...{
                    SliverList.builder(
                      itemCount: state.songs.length,
                      itemBuilder: (context, index) => SongTile(
                        song: state.songs[index],
                        onTap: () async {
                          await PlayerAudio.setAudioSource(
                            state.songs,
                            index,
                          );
                        },
                        moreOnTap: () async {
                          if (audiosFromType == AudiosFromType.PLAYLIST) {
                            await morePlaylistBottomSheet(context,
                                state.songs[index], id, audiosFromType, path);
                          } else {
                            await moreBottomSheet(context, state.songs[index]);
                          }
                        },
                      ),
                    )
                  } else if (state is SongListEmpty) ...{
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/error-icon.svg",
                              // ignore: deprecated_member_use
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.empty,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    )
                  } else if (state is SongListError) ...{
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/error-icon.svg",
                              // ignore: deprecated_member_use
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.error,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<SongBloc>(context).add(
                                      GetSongListEvent(
                                          id, audiosFromType, path));
                                },
                                child: const Text(
                                  "Try again",
                                )),
                          ],
                        ),
                      ),
                    )
                  } else if (state is SongListLoading) ...{
                    const SliverFillRemaining(
                        hasScrollBody: false, child: Loading())
                  } else ...{
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/error-icon.svg",
                              // ignore: deprecated_member_use
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "An unknown error occurred",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<SongBloc>(context).add(
                                      GetSongListEvent(
                                          id, audiosFromType, path));
                                },
                                child: const Text(
                                  "Try again",
                                )),
                          ],
                        ),
                      ),
                    )
                  },
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 75),
                  )
                ],
              );
            },
          )),
    );
  }

  Widget _playandshuffle(List<SongModel> songs) {
    final Random random = Random();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () async {
              if (songs.isNotEmpty) {
                await PlayerAudio.setAudioSource(
                    songs, random.nextInt(songs.length),
                    isShuffle: true);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(8),
              decoration: const ShapeDecoration(
                color: Color(0x26F4F4F4),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(
                "assets/svg/shuffle-icon.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
            )),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
            onTap: () async {
              if (songs.isNotEmpty) {
                await PlayerAudio.setAudioSource(
                  songs,
                  0,
                );
              }
            },
            child: Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(5),
              decoration: const ShapeDecoration(
                color: Color(0x26F4F4F4),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(
                "assets/svg/play-album-icon.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}

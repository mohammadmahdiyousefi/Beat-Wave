import 'package:beat_wave/widget/bottomsheet/bottom_sheet_item.dart';
import 'package:beat_wave/widget/bottomsheet/song_more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/playlist/playlist_bloc.dart';
import 'package:beat_wave/bloc/playlist/playlist_event.dart';
import 'package:beat_wave/bloc/playlist/playlist_state.dart';
import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/view/miniplayer.dart';
import 'package:beat_wave/view/song_list.dart';
import 'package:beat_wave/widget/creat_playlist_diolog.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:beat_wave/widget/navigator.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListScreen extends StatelessWidget {
  PlayListScreen({
    super.key,
  });
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Playlists",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
//------------------ state playlist true ---------------------------------------
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<PlaylistBloc>(context).add(GetPlaylistEvent());
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ListTile(
                      title: const Text("Create Playlist"),
                      leading: const Icon(Icons.add),
                      contentPadding: const EdgeInsets.only(left: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onTap: () async {
                        await craetePlaylist(context);
                      },
                    ),
                  ),
                ),
                (state is PlayList)
                    ? SliverList.builder(
                        itemCount: state.playlist.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListTile(
                              onTap: () {
                                customNavigator(
                                  context: context,
                                  page: SongListScreen(
                                      id: state.playlist[index].id,
                                      nullArtwork: "assets/images/song.png",
                                      title: state.playlist[index].playlist,
                                      appbarTitle: "Playlist",
                                      type: ArtworkType.PLAYLIST,
                                      audiosFromType: AudiosFromType.PLAYLIST),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              title: Text(
                                state.playlist[index].playlist,
                                overflow: TextOverflow.ellipsis,
                              ),
                              titleTextStyle: Theme.of(context)
                                  .listTileTheme
                                  .titleTextStyle,
                              subtitle: Text(
                                "${state.playlist[index].numOfSongs} ${state.playlist[index].numOfSongs <= 1 ? "song" : "songs"}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitleTextStyle: Theme.of(context)
                                  .listTileTheme
                                  .subtitleTextStyle,
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                      "assets/images/song.png",
                                    ))),
                                child: QueryArtworkWidget(
                                  id: state.playlist[index].id,
                                  quality: 50,
                                  size: 200,
                                  format: ArtworkFormat.JPEG,
                                  controller: onAudioQuery,
                                  type: ArtworkType.PLAYLIST,
                                  keepOldArtwork: true,
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
                                            "assets/images/song.png",
                                          ),
                                          filterQuality: FilterQuality.low,
                                          fit: BoxFit.cover),
                                      color:
                                          const Color.fromARGB(255, 61, 60, 60),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await moreBottomSheet(
                                      context,
                                      ListTile(
                                        shape: Theme.of(context)
                                            .listTileTheme
                                            .shape,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 7),
                                        title: Text(
                                            state.playlist[index].playlist),
                                        titleTextStyle: Theme.of(context)
                                            .listTileTheme
                                            .titleTextStyle,
                                        subtitle: Text(
                                          "${state.playlist[index].numOfSongs} ${state.playlist[index].numOfSongs <= 1 ? "song" : "songs"}",
                                        ),
                                        subtitleTextStyle: Theme.of(context)
                                            .listTileTheme
                                            .subtitleTextStyle,
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/cover.jpg"))),
                                          child: QueryArtworkWidget(
                                            id: state.playlist[index].id,
                                            quality: 50,
                                            size: 200,
                                            controller: onAudioQuery,
                                            format: ArtworkFormat.JPEG,
                                            type: ArtworkType.AUDIO,
                                            keepOldArtwork: false,
                                            artworkBorder:
                                                BorderRadius.circular(6),
                                            artworkQuality: FilterQuality.low,
                                            artworkFit: BoxFit.fill,
                                            artworkHeight: 50,
                                            artworkWidth: 50,
                                            nullArtworkWidget: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/cover.jpg",
                                                    ),
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    fit: BoxFit.cover),
                                                color: const Color.fromARGB(
                                                    255, 61, 60, 60),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      playlistItems(
                                          context, state.playlist[index]));
                                },
                              ),
                            ),
                          );
                        })
                    : (state is PlayListLoading)
                        ? const SliverFillRemaining(
                            hasScrollBody: false, child: Loading())
                        : (state is PlayListEmpty)
                            ? SliverFillRemaining(
                                hasScrollBody: false,
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            : (state is PlayListError)
                                ? SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/error-icon.svg",
                                            // ignore: deprecated_member_use
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            state.error,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                BlocProvider.of<PlaylistBloc>(
                                                        context)
                                                    .add(GetPlaylistEvent());
                                              },
                                              child: const Text(
                                                "try agine",
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/error-icon.svg",
                                            // ignore: deprecated_member_use
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Error",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                BlocProvider.of<PlaylistBloc>(
                                                        context)
                                                    .add(GetPlaylistEvent());
                                              },
                                              child: const Text(
                                                "Try again",
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

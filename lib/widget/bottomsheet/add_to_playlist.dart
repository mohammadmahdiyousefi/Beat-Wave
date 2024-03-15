import 'package:beat_wave/widget/toastflutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/playlist/playlist_bloc.dart';
import 'package:beat_wave/bloc/playlist/playlist_event.dart';
import 'package:beat_wave/bloc/playlist/playlist_state.dart';
import 'package:beat_wave/service/playlist_service/playlist.dart';
import 'package:beat_wave/widget/creat_playlist_diolog.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<Widget?> addtoplaylistbottomshet(
  BuildContext context,
  SongModel song,
) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    elevation: Theme.of(context).bottomSheetTheme.elevation,
    shape: Theme.of(context).bottomSheetTheme.shape,
    constraints: const BoxConstraints(maxHeight: 360),
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) {
          var playlistBloc = PlaylistBloc();
          playlistBloc.add(GetPlaylistEvent());
          return playlistBloc;
        },
        child: AddToPlaylistView(
          song: song,
        ),
      );
    },
  );
}

class AddToPlaylistView extends StatelessWidget {
  const AddToPlaylistView({super.key, required this.song});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(builder: (context, state) {
      //------------------ state playlist true ---------------------------------------
      return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<PlaylistBloc>(context).add(GetPlaylistEvent());
        },
        child: CustomScrollView(shrinkWrap: true, slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            elevation: Theme.of(context).bottomSheetTheme.elevation,
            shape: Theme.of(context).bottomSheetTheme.shape,
            automaticallyImplyLeading: false,
            pinned: true,
            centerTitle: true,
            toolbarHeight: 60,
            scrolledUnderElevation: 0,
            title: ListTile(
              title: const Text("Create Playlist"),
              leading: const Icon(Icons.add),
              contentPadding: const EdgeInsets.only(left: 20),
              shape: Theme.of(context).listTileTheme.shape,
              onTap: () async {
                await craetePlaylist(context);
              },
            ),
            bottom: const PreferredSize(
              preferredSize: Size(double.infinity, 3),
              child: Divider(
                thickness: 1,
                height: 3,
                indent: 16,
                endIndent: 16,
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
                        onTap: () async {
                          await PlayListHandler.addToPlaylist(
                                  state.playlist[index].id, song.id)
                              .then((value) {
                            if (value) {
                              BlocProvider.of<PlaylistBloc>(context)
                                  .add(GetPlaylistEvent());
                              toast(context, "Added to playlist successfully");
                            } else {
                              toast(context, "Error");
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 7),
                        title: Text(
                          state.playlist[index].playlist,
                          overflow: TextOverflow.ellipsis,
                        ),
                        titleTextStyle:
                            Theme.of(context).listTileTheme.titleTextStyle,
                        subtitle: Text(
                          "${state.playlist[index].numOfSongs} ${state.playlist[index].numOfSongs <= 1 ? "song" : "songs"}",
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitleTextStyle:
                            Theme.of(context).listTileTheme.subtitleTextStyle,
                        leading: QueryArtworkWidget(
                          id: state.playlist[index].id,
                          quality: 50,
                          size: 200,
                          format: ArtworkFormat.JPEG,
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
                              color: const Color.fromARGB(255, 61, 60, 60),
                            ),
                          ),
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
                                style: Theme.of(context).textTheme.bodySmall,
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
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<PlaylistBloc>(context)
                                              .add(GetPlaylistEvent());
                                        },
                                        child: const Text(
                                          "Try again",
                                        )),
                                  ],
                                ),
                              ),
                            )
                          : SliverToBoxAdapter(
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
                                      "Error",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<PlaylistBloc>(context)
                                              .add(GetPlaylistEvent());
                                        },
                                        child: const Text(
                                          "Try again",
                                        )),
                                  ],
                                ),
                              ),
                            ),
        ]),
      );
    });
  }
}

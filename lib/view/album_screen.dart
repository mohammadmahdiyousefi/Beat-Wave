import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/album/album_bloc.dart';
import 'package:beat_wave/bloc/album/album_state.dart';
import 'package:beat_wave/view/miniplayer.dart';
import 'package:beat_wave/view/song_list.dart';
import 'package:beat_wave/widget/gride_view_widget.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:beat_wave/widget/navigator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/album/album_event.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          "Album",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
        //----------------------  state album true state -------------------------------
        if (state is AlbumList) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<AlbumBloc>(context).add(GetAlbumEvent());
            },
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 6)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16),
                    itemCount: state.albums.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () async {
                            customNavigator(
                              context: context,
                              page: SongListScreen(
                                  id: state.albums[index].id,
                                  nullArtwork: "assets/images/album.png",
                                  title: state.albums[index].album,
                                  appbarTitle: "Album",
                                  type: ArtworkType.ALBUM,
                                  audiosFromType: AudiosFromType.ALBUM_ID),
                            );
                          },
                          child: GrideViewWidget(
                            id: state.albums[index].id,
                            name: state.albums[index].album,
                            numberofsong: state.albums[index].numOfSongs,
                            nullartwork: "assets/images/album.png",
                          ));
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                )
              ],
            ),
          );
        }
        //------------------------------------------------------------------------------
        //----------------- loding mode state -----------------------------------------
        else if (state is AlbumLoading) {
          return const Loading();
        }
        //------------------------------------------------------------------------------
        //---------------- empty mode state -------------------------------------------
        else if (state is AlbumEmpty) {
          return Center(
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
          );
        }
        //------------------------------------------------------------------------------
        //----------------- error mode state -------------------------------------------
        else if (state is AlbumError) {
          return Center(
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
                      BlocProvider.of<AlbumBloc>(context).add(GetAlbumEvent());
                    },
                    child: const Text(
                      "Try again",
                    )),
              ],
            ),
          );
        }
        //------------------------------------------------------------------------------
        //---------------- other mode --------------------------------------------------
        else {
          return Center(
            child: Column(
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
                  "An unknown error occurred while loading albums",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AlbumBloc>(context).add(GetAlbumEvent());
                    },
                    child: const Text(
                      "Try again",
                    )),
              ],
            ),
          );
        }
        //------------------------------------------------------------------------------
      }),
    );
  }
}

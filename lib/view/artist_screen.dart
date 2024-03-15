import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/artist/artist_bloc.dart';
import 'package:beat_wave/bloc/artist/artist_state.dart';
import 'package:beat_wave/view/miniplayer.dart';
import 'package:beat_wave/view/song_list.dart';
import 'package:beat_wave/widget/gride_view_widget.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:beat_wave/widget/navigator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/artist/artist_event.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

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
          "Artist",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: BlocBuilder<ArtistBloc, ArtistState>(
        builder: (context, state) {
//------------------- state true artist ----------------------------------------
          if (state is ArtistList) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<ArtistBloc>(context).add(GetArtistEvent());
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
                      itemCount: state.artists.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              customNavigator(
                                context: context,
                                page: SongListScreen(
                                    id: state.artists[index].id,
                                    nullArtwork: "assets/images/artist.png",
                                    title: state.artists[index].artist,
                                    appbarTitle: "Artist",
                                    type: ArtworkType.ARTIST,
                                    audiosFromType: AudiosFromType.ARTIST_ID),
                              );
                            },
                            child: GrideViewWidget(
                              id: state.artists[index].id,
                              name: state.artists[index].artist,
                              numberofsong:
                                  state.artists[index].numberOfTracks!,
                              type: ArtworkType.ARTIST,
                              nullartwork: "assets/images/artist.png",
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
//---------------- loding state ------------------------------------------------
          else if (state is ArtistLoading) {
            return const Loading();
          }
//------------------------------------------------------------------------------
//----------------- empty state -----------------------------------------------
          else if (state is ArtistEmpty) {
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
//------------------- error state ----------------------------------------------
          else if (state is ArtistError) {
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
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<ArtistBloc>(context)
                            .add(GetArtistEvent());
                      },
                      child: const Text(
                        "Try again",
                      )),
                ],
              ),
            );
          }
//------------------------------------------------------------------------------
//---------------- other state -------------------------------------------------
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
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () {
                        BlocProvider.of<ArtistBloc>(context)
                            .add(GetArtistEvent());
                      },
                      child: const Text(
                        "Try again",
                      )),
                ],
              ),
            );
          }
//------------------------------------------------------------------------------
        },
      ),
    );
  }
}

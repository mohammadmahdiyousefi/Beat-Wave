import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/artist/artist_bloc.dart';
import 'package:justaudioplayer/bloc/artist/artist_state.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/artist/artist_event.dart';
import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';
import '../widget/artwork_widget.dart';

// ignore: must_be_immutable
class ArtistScreen extends StatelessWidget {
  ArtistScreen({
    super.key,
  });
  ScrollController scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<ArtistBloc, IArtistState>(builder: (context, state) {
      if (state is ArtistState) {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () async {
            BlocProvider.of<ArtistBloc>(context).add(ArtistEvent());
          },
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                child: Scrollbar(
                  interactive: true,
                  controller: scrollcontroller,
                  thumbVisibility: true,
                  thickness: 6,
                  radius: const Radius.circular(10),
                  child: GridView.builder(
                    controller: scrollcontroller,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 15),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.artists.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          BlocProvider.of<SongBloc>(context).add(
                              ArtistListEvent(state.artists[index].artist));
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SongListScreen(
                                    state.artists[index].artist,
                                    state.artists[index].numberOfTracks!,
                                    id: state.artists[index].id,
                                    type: ArtworkType.ARTIST,
                                    nullartwork: "assets/images/artist.png",
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ArtworkSong(
                                id: state.artists[index].id,
                                height: height * 0.18,
                                width: height * 0.18,
                                size: 300,
                                quality: 25,
                                type: ArtworkType.ARTIST,
                                nullartwork: "assets/images/artist.png",
                                radius: 20,
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              SizedBox(
                                width: width * 0.6,
                                child: Center(
                                  child: Text(
                                    state.artists[index].artist.trim(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                '${state.artists[index].numberOfTracks} Songs'
                                    .toString(),
                                style: GoogleFonts.roboto(
                                  color: Colors.grey.shade700,
                                  fontSize: 9,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (state is ArtistErrorState) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ArtistBloc>(context).add(ArtistEvent());
                  },
                  child: const Text("retry")),
            ],
          ),
        );
      } else if (state is LoadArtistState) {
        return Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        );
      } else if (state is InitArtistState) {
        return Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        );
      } else {
        return Center(
          child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<ArtistBloc>(context).add(ArtistEvent());
              },
              child: const Text("retry")),
        );
      }
    });
  }
}

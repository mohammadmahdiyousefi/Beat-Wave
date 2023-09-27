import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/album/album_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:justaudioplayer/widget/artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/album/album_event.dart';
import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';

// ignore: must_be_immutable
class AlbumScreen extends StatelessWidget {
  AlbumScreen({
    super.key,
  });
  ScrollController scrollcontroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<AlbumBloc, IAlbumState>(builder: (context, state) {
      if (state is AlbumState) {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () async {
            BlocProvider.of<AlbumBloc>(context).add(AlbumEvent());
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
                            crossAxisCount: 2, mainAxisSpacing: 12),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.albums.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          BlocProvider.of<SongBloc>(context)
                              .add(AlbumListEvent(state.albums[index].id));
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SongListScreen(
                                    state.albums[index].album,
                                    state.albums[index].numOfSongs,
                                    id: state.albums[index].id,
                                    type: ArtworkType.ALBUM,
                                    nullartwork: "assets/images/album.png",
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.transparent),
                          child: Column(
                            children: [
                              ArtworkSong(
                                id: state.albums[index].id,
                                height: height * 0.18,
                                width: height * 0.18,
                                size: 300,
                                quality: 25,
                                type: ArtworkType.ALBUM,
                                nullartwork: "assets/images/album.png",
                                radius: 20,
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              SizedBox(
                                width: width * 0.6,
                                child: Center(
                                  child: Text(
                                    state.albums[index].album.trim(),
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
                                '${state.albums[index].numOfSongs} Songs'
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
      } else if (state is AlbumErrorState) {
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
                    BlocProvider.of<AlbumBloc>(context).add(AlbumEvent());
                  },
                  child: const Text("retry")),
            ],
          ),
        );
      } else if (state is LoadAlbumState) {
        return Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        );
      } else if (state is InitAlbumState) {
        return Center(
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        );
      } else {
        return Center(
          child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AlbumBloc>(context).add(AlbumEvent());
              },
              child: const Text("retry")),
        );
      }
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:justaudioplayer/widget/creat_playlist_diolog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';
import '../widget/artwork_widget.dart';

// ignore: must_be_immutable
class PlayListScren extends StatelessWidget {
  PlayListScren(
    this.isadd, {
    super.key,
    this.song,
  });
  ScrollController scrollcontroller = ScrollController();
  bool isadd;
  SongModel? song;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await addToPlaylistdiolog(context);
          },
          child: Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: const Color(0xff212121),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xff2962FF),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Creat Playlist",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: BlocBuilder<PlaylistBloc, IPlaylistState>(
            builder: (context, state) {
          if (state is PlaylistState) {
            return AnimationLimiter(
              child: CupertinoScrollbar(
                controller: scrollcontroller,
                thumbVisibility: true,
                thickness: 9,
                thicknessWhileDragging: 12,
                radius: const Radius.circular(10),
                child: GridView.builder(
                  controller: scrollcontroller,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.playlist.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: (state.playlist.length / 2).round(),
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onLongPress: () async {
                              await editPlaylistdiolog(
                                  context, state.playlist[index]);
                            },
                            onTap: () async {
                              if (isadd == true) {
                                BlocProvider.of<PlaylistBloc>(context)
                                    .add(AddtoPlaylistEvent(
                                  state.playlist[index].id,
                                  song!.id,
                                ));
                              } else {
                                BlocProvider.of<SongBloc>(context).add(
                                    PlasyListEvent(
                                        state.playlist[index].playlist));
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: SongListScreen(
                                          state.playlist[index].playlist,
                                          state.playlist[index].numOfSongs,
                                          id: state.playlist[index].id,
                                          type: ArtworkType.PLAYLIST,
                                          nullartwork:
                                              "assets/images/cover.png",
                                        )));
                              }
                            },
                            child: Container(
                              height: 160,
                              width: 130,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent),
                              child: Column(
                                children: [
                                  ArtworkSong(
                                    id: state.playlist[index].id,
                                    height: 130,
                                    width: 130,
                                    size: 300,
                                    quality: 30,
                                    type: ArtworkType.PLAYLIST,
                                    //  nullartwork: "assets/images/Ar.png",
                                    radius: 20,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        state.playlist[index].playlist.trim(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${state.playlist[index].numOfSongs} Songs'
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }))
      ],
    );
  }
}

Future editPlaylistdiolog(BuildContext context, PlaylistModel playlist) {
  TextEditingController controler =
      TextEditingController(text: playlist.playlist);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Edit Playlist',
            ),
          ],
        )),
        backgroundColor: const Color(0xff212121),
        titleTextStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
        ),
        content: SizedBox(
          height: 150,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: controler,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      hintText: "Rename Playlist Name",
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xff2962FF),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2962FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          BlocProvider.of<PlaylistBloc>(context)
                              .add(RemovePlaylistEvent(playlist.id));

                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.delete)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2962FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          BlocProvider.of<PlaylistBloc>(context).add(
                              EditPlaylistEvent(playlist.id, controler.text));
                          Navigator.pop(context);
                        },
                        child: const Text("Save")),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

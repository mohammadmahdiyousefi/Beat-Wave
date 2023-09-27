import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/model/playlist.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:justaudioplayer/widget/creat_playlist_diolog.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';
import '../widget/artwork_widget.dart';

// ignore: must_be_immutable
class PlayListScren extends StatelessWidget {
  PlayListScren({
    super.key,
    this.song,
  });
  ScrollController scrollcontroller = ScrollController();

  SongModel? song;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(child: BlocBuilder<PlaylistBloc, IPlaylistState>(
            builder: (context, state) {
          if (state is PlaylistState) {
            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onRefresh: () async {
                BlocProvider.of<PlaylistBloc>(context).add(PlaylistEvent());
              },
              child: Scrollbar(
                interactive: true,
                controller: scrollcontroller,
                thumbVisibility: true,
                thickness: 6,
                radius: const Radius.circular(10),
                child: CustomScrollView(controller: scrollcontroller, slivers: [
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () async {
                        await addToPlaylistdiolog(context);
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Theme.of(context).cardColor,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Container(
                          height: height * 0.065,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Container(
                                height: height * 0.05,
                                width: height * 0.05,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.032,
                              ),
                              Text("Creat Playlist",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 12),
                      itemCount: state.playlist.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () async {
                            await editPlaylistdiolog(
                                context, state.playlist[index]);
                          },
                          onTap: () async {
                            BlocProvider.of<SongBloc>(context).add(
                                PlasyListEvent(state.playlist[index].name));
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SongListScreen(
                                      state.playlist[index].name,
                                      state.playlist[index].songs.length,
                                      id: state.playlist[index].imageid ?? 0,
                                      type: ArtworkType.AUDIO,
                                      nullartwork: "assets/images/cover.jpg",
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
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ArtworkSong(
                                      id: state.playlist[index].imageid ?? 0,
                                      height: height * 0.18,
                                      width: height * 0.18,
                                      size: 300,
                                      quality: 30,
                                      type: ArtworkType.AUDIO,
                                      radius: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.012,
                                ),
                                SizedBox(
                                  width: width * 0.6,
                                  child: Center(
                                    child: Text(
                                      state.playlist[index].name.trim(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  '${state.playlist[index].songs.length} Songs'
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
                        );
                      })
                ]),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        }))
      ],
    );
  }
}

Future editPlaylistdiolog(BuildContext context, Playlist playlist) {
  TextEditingController controler = TextEditingController(text: playlist.name);
  TextEditingController imageidcontroler =
      TextEditingController(text: playlist.imageid.toString());
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.edit,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              'Edit Playlist',
            ),
          ],
        )),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        content: SizedBox(
          height: 250,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: controler,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                      labelText: "Playlist Name",
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                      hintText: "Rename Playlist Name",
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: imageidcontroler,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                      labelText: "Image Id",
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                      hintText: "Image Id",
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
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
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          BlocProvider.of<PlaylistBloc>(context)
                              .add(RemovePlaylistEvent(playlist.name));

                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.delete)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          BlocProvider.of<PlaylistBloc>(context).add(
                              EditPlaylistEvent(
                                  int.parse(imageidcontroler.text),
                                  playlist.name,
                                  controler.text));
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

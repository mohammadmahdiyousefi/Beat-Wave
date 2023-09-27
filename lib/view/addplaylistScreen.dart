import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/playlist/playlist_bloc.dart';
import '../bloc/playlist/playlist_event.dart';
import '../bloc/playlist/playlist_state.dart';
import '../widget/artwork_widget.dart';
import '../widget/creat_playlist_diolog.dart';

// ignore: must_be_immutable
class AddPlaylistScreen extends StatelessWidget {
  AddPlaylistScreen(this.song, {super.key});
  ScrollController scrollcontroller = ScrollController();
  SongModel? song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<PlaylistBloc, IPlaylistState>(builder: (context, state) {
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
                          horizontal: 10, vertical: 15),
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text("Creat Playlist",
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: state.playlist.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () async {
                          // await editPlaylistdiolog(
                          //     context, state.playlist[index]);
                        },
                        onTap: () async {
                          BlocProvider.of<PlaylistBloc>(context).add(
                              AddRemovetoPlaylistEvent(
                                  state.playlist[index].name, song!));
                          // BlocProvider.of<SongBloc>(context)
                          //     .add(PlasyListEvent(state.playlist[index].name));
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
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ArtworkSong(
                                    id: state.playlist[index].imageid ?? 0,
                                    height: 130,
                                    width: 130,
                                    size: 300,
                                    quality: 30,
                                    type: ArtworkType.AUDIO,
                                    //  nullartwork: "assets/images/Ar.png",
                                    radius: 20,
                                  ),
                                  Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: state.playlist[index].songs
                                                  .contains(
                                                      jsonEncode(song!.getMap))
                                              ? const Color.fromARGB(
                                                  118, 158, 158, 158)
                                              : Colors.transparent),
                                      child: state.playlist[index].songs
                                              .contains(
                                                  jsonEncode(song!.getMap))
                                          ? Icon(
                                              Icons.check,
                                              size: 45,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : null),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(
                                  child: Text(
                                    state.playlist[index].name.trim(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
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
          ));
        }
      }),
    );
  }
}

// ignore_for_file: sort_child_properties_last
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/widget/song_info_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';
import '../bloc/favoritesong/favorite_song_bloc.dart';
import '../bloc/favoritesong/favorite_song_event.dart';
import 'add_to_playlist.dart';

// ignore: must_be_immutable
class SongeMore extends StatelessWidget {
  SongeMore(this.song, this.index, {super.key});
  SongModel song;
  int? index;
  final favoritebox = Hive.box('FavoriteSongs');
  final box = Hive.box('songlist');
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        splashRadius: 15,
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).iconTheme.color,
        ),
        onSelected: (value) async {
          // your logic
          if (value == '/Song Info') {
            songInfo(context, song);
          }
          if (value == '/Favorit') {
            if (favoritebox.values.toList().contains(jsonEncode(song.getMap))) {
              BlocProvider.of<FavoritSongBloc>(context)
                  .add(DeleteFavoriteSongeEvent(jsonEncode(song.getMap)));
            } else {
              BlocProvider.of<FavoritSongBloc>(context)
                  .add(AddFavoriteSongeEvent(jsonEncode(song.getMap)));
            }
          }
          if (value == '/Share') {
            if (song.fileExtension == "Network") {
              await Share.shareWithResult(song.uri!);
            } else {
              await Share.shareXFiles([XFile(song.data)],
                  text: song.displayName);
            }
          }
          if (value == '/Add Play List') {
            // ignore: use_build_context_synchronously
            addtoplaylistbottomshet(context, song);
          }
        },
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.playlist_add,
                    color: Theme.of(context).iconTheme.color,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Add Play List",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              value: '/Add Play List',
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                      valueListenable: favoritebox.listenable(),
                      builder: (context, value, child) {
                        if (favoritebox.isEmpty) {
                          return Icon(
                            Icons.favorite_outline,
                            color: Theme.of(context).iconTheme.color,
                          );
                        } else {
                          return Icon(
                            favoritebox.values
                                        .toList()
                                        .contains(jsonEncode(song.getMap)) ==
                                    true
                                ? Icons.favorite_sharp
                                : Icons.favorite_outline,
                            color: favoritebox.values
                                        .toList()
                                        .contains(jsonEncode(song.getMap)) ==
                                    true
                                ? Colors.red
                                : Theme.of(context).iconTheme.color,
                          );
                        }
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Favorit",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              value: '/Favorit',
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.share,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Share", style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              value: '/Share',
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info,
                    color: Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Song Info",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              value: '/Song Info',
            ),
          ];
        });
  }
}

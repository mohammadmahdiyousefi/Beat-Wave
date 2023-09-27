// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/widget/song_info_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class SongenetworkMore extends StatelessWidget {
  SongenetworkMore(this.song, this.index, {super.key});
  SongModel song;
  int? index;
  final networkbox = Hive.box('NetworkSonglist');
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
          if (value == '/Delete') {
            networkbox
                .deleteAt(networkbox.values.toList().indexOf(song.getMap));
          }
          if (value == '/Share') {
            await Share.share(song.uri!);
          }
          if (value == '/Download') {}
        },
        itemBuilder: (BuildContext bc) {
          return [
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.download_outlined,
                    color: Theme.of(context).iconTheme.color,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Download",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              value: '/Download',
            ),
            // PopupMenuItem(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Icon(
            //         Icons.delete_outline,
            //         color: Theme.of(context).iconTheme.color,
            //         size: 25,
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Text("Delete",
            //           style: Theme.of(context).textTheme.titleMedium),
            //     ],
            //   ),
            //   value: '/Delete',
            // ),
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

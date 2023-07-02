// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:justaudioplayer/widget/song_info_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class SongeMore extends StatelessWidget {
  SongeMore(this.song, {super.key});
  SongModel song;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: const Color(0xff212121),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        splashRadius: 15,
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: (value) async {
          // your logic
          if (value == '/Song Info') {
            songInfo(context, song);
          }
          if (value == '/Share') {
            await Share.shareXFiles([XFile(song.data)], text: song.displayName);
          }
        },
        itemBuilder: (BuildContext bc) {
          return const [
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add Play List",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: '/Add Play List',
            ),
            PopupMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
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
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Song Info",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: '/Song Info',
            ),
          ];
        });
  }
}

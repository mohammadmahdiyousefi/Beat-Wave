import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritButton extends StatelessWidget {
  FavoritButton(
      {super.key, required this.song, this.size, this.color = Colors.white});
  final SongModel song;
  final double? size;
  final Color color;
  final Box<String> favoritebox = Hive.box<String>('FavoriteSongs');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoritebox.listenable(),
        builder: (context, favorit, child) {
          final List<String> boxList = favorit.values.toList();
          final bool isfavorit = boxList.contains(jsonEncode(song.getMap));
          return IconButton(
            onPressed: () async {
              if (isfavorit) {
                final int index = boxList.indexWhere(
                    (element) => element == jsonEncode(song.getMap));
                favoritebox.deleteAt(index);
              } else {
                favoritebox.add(jsonEncode(song.getMap));
              }
            },
            icon: Icon(
              isfavorit ? Icons.favorite_sharp : Icons.favorite_outline,
              color: isfavorit ? Colors.red : color,
              size: size,
            ),
          );
        });
  }
}

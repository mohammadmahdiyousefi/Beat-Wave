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
  final Box favoritebox = Hive.box('FavoriteSongs');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: favoritebox.listenable(),
        builder: (context, favorit, child) {
          final List<dynamic> boxList = favorit.values.toList();
          final bool isfavorit = boxList
              .where(
                  (element) => SongModel(jsonDecode(element)).data == song.data)
              .isEmpty;
          return IconButton(
            onPressed: () async {
              if (isfavorit) {
                favoritebox.add(jsonEncode(song.getMap));
              } else {
                final int index = boxList.indexWhere((element) =>
                    SongModel(jsonDecode(element)).data == song.data);
                favoritebox.deleteAt(index);
              }
            },
            icon: Icon(
              isfavorit ? Icons.favorite_outline : Icons.favorite_sharp,
              color: isfavorit ? color : Colors.red,
              size: size,
            ),
          );
        });
  }
}

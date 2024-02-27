import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justaudioplayer/data/model/player.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widget/song_tile.dart';

class FavoritScreen extends StatelessWidget {
  FavoritScreen({super.key});

  final Box<String> favoritebox = Hive.box<String>('FavoriteSongs');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Favorites",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: ValueListenableBuilder(
        valueListenable: favoritebox.listenable(),
        builder: (context, favorit, child) {
          if (favorit.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/error-icon.svg",
                    // ignore: deprecated_member_use
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Unfortunately, no favorite music was found",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else {
            final List<dynamic> boxList = favorit.values.toList();
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 6)),
                SliverList.builder(
                    itemCount: boxList.length,
                    itemBuilder: (context, index) => SongTile(
                          song: SongModel(jsonDecode(boxList[index])),
                          onTap: () async {
                            await PlayerAudio.setAudioSource(
                              loadSongList(favorit),
                              index,
                            );
                          },
                          moreOnTap: () async {
                            await moreBottomSheet(
                                context, SongModel(jsonDecode(boxList[index])));
                          },
                        )),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 90),
                )
              ],
            );
          }
        },
      ),
    );
  }

  List<SongModel> loadSongList(Box box) {
    List<SongModel> favoritSongs = [];
    for (var song in box.values.toList()) {
      dynamic decodedJson = jsonDecode(song);
      SongModel audio = SongModel(decodedJson);
      favoritSongs.add(audio);
    }
    return favoritSongs;
  }
}

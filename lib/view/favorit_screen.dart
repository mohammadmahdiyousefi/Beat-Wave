import 'dart:convert';
import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/service/player_service/player.dart';
import 'package:beat_wave/widget/bottomsheet/bottom_sheet_item.dart';
import 'package:beat_wave/widget/favorit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:beat_wave/view/miniplayer.dart';
import 'package:beat_wave/widget/bottomsheet/song_more.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widget/song_tile.dart';

class FavoritScreen extends StatelessWidget {
  FavoritScreen({super.key});
  final Box<String> favoritebox = Hive.box<String>('FavoriteSongs');
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
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
                              _loadSongList(favorit),
                              index,
                            );
                          },
                          moreOnTap: () async {
                            await moreBottomSheet(
                              context,
                              ListTile(
                                shape: Theme.of(context).listTileTheme.shape,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                title: Text(
                                    SongModel(jsonDecode(boxList[index]))
                                        .title),
                                titleTextStyle: Theme.of(context)
                                    .listTileTheme
                                    .titleTextStyle,
                                subtitle: Text(
                                    SongModel(jsonDecode(boxList[index]))
                                            .artist ??
                                        "<unkown>"),
                                subtitleTextStyle: Theme.of(context)
                                    .listTileTheme
                                    .subtitleTextStyle,
                                trailing: FavoritButton(
                                  song: SongModel(jsonDecode(boxList[index])),
                                  color: Theme.of(context).iconTheme.color ??
                                      Colors.grey,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/cover.jpg"))),
                                  child: QueryArtworkWidget(
                                    id: SongModel(jsonDecode(boxList[index]))
                                        .id,
                                    quality: 50,
                                    size: 200,
                                    controller: onAudioQuery,
                                    format: ArtworkFormat.JPEG,
                                    type: ArtworkType.AUDIO,
                                    keepOldArtwork: false,
                                    artworkBorder: BorderRadius.circular(6),
                                    artworkQuality: FilterQuality.low,
                                    artworkFit: BoxFit.fill,
                                    artworkHeight: 50,
                                    artworkWidth: 50,
                                    nullArtworkWidget: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/cover.jpg",
                                            ),
                                            filterQuality: FilterQuality.low,
                                            fit: BoxFit.cover),
                                        color: const Color.fromARGB(
                                            255, 61, 60, 60),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              songItems(
                                context,
                                SongModel(
                                  jsonDecode(
                                    boxList[index],
                                  ),
                                ),
                              ),
                            );
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

  List<SongModel> _loadSongList(Box box) {
    List<SongModel> favoritSongs = [];
    for (var song in box.values.toList()) {
      dynamic decodedJson = jsonDecode(song);
      SongModel audio = SongModel(decodedJson);
      favoritSongs.add(audio);
    }
    return favoritSongs;
  }
}

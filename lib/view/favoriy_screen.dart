import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/favoritesong/favorite_song_bloc.dart';
import '../bloc/player/player.bloc.dart';
import '../bloc/player/player_event.dart';
import '../widget/song _tile.dart';

// ignore: must_be_immutable
class FavoritScreen extends StatelessWidget {
  FavoritScreen({
    super.key,
  });
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritSongBloc, IFavoriteSongsState>(
        builder: (context, state) {
      if (state is FavoriteSongsstete) {
        if (state.favoriteSongs.isEmpty) {
          return const Center(
            child: Text(
              "Empty",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        } else {
          return AnimationLimiter(
            child: CupertinoScrollbar(
              thumbVisibility: true,
              thickness: 9,
              thicknessWhileDragging: 12,
              radius: const Radius.circular(10),
              controller: controller,
              child: ListView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.favoriteSongs.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () async {
                              BlocProvider.of<PlayerBloc>(context).add(
                                  InitPlayerEnent(state.favoriteSongs, index,
                                      "Favoritesong"));
                              BlocProvider.of<PlayerBloc>(
                                context,
                              ).add(StartPlayerEnent());
                            },
                            child: SongTile(
                                index, "Favoritesong", state.favoriteSongs)),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
// class FavoritScreen extends StatefulWidget {
//   const FavoritScreen({super.key});

//   @override
//   State<FavoritScreen> createState() => _FavoritScreenState();
// }

// class _FavoritScreenState extends State<FavoritScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

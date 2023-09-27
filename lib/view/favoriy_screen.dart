import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_state.dart';
import '../bloc/favoritesong/favorite_song_bloc.dart';
import '../bloc/favoritesong/favorite_song_event.dart';
import '../bloc/player/player_bloc.dart';
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
          return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onRefresh: () async {
              BlocProvider.of<FavoritSongBloc>(context)
                  .add(FavoriteSongeEvent());
            },
            child: Scrollbar(
              interactive: true,
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              controller: controller,
              child: ListView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.favoriteSongs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () async {
                        BlocProvider.of<PlayerBloc>(context).add(
                            InitPlayerEnent(
                                state.favoriteSongs, index, "Favoritesong"));
                        BlocProvider.of<PlayerBloc>(
                          context,
                        ).add(StartPlayerEnent());
                      },
                      child: SongTile(
                        index,
                        "Favoritesong",
                        state.favoriteSongs,
                      ));
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

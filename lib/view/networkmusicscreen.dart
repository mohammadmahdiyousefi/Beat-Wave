import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_network_bloc.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_network_state.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:justaudioplayer/widget/song%20_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'miniplayer.dart';

class NetworkMusicScreen extends StatelessWidget {
  const NetworkMusicScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(child: BlocBuilder<MusicNetworkBloc, IMusicNetworkState>(
              builder: (context, state) {
            if (state is MusicNetworkState) {
              return ListView.builder(
                itemCount: state.musics.length,
                itemBuilder: (context, index) {
                  return SongTile(
                    index,
                    "Network",
                    state.musics,
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          })),
          Miniplayer(),
        ],
      ),
    ));
  }
}

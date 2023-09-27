import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../bloc/player/player_bloc.dart';
import '../bloc/player/player_event.dart';

// ignore: must_be_immutable
class PlaySuffelbutton extends StatelessWidget {
  PlaySuffelbutton(this.path, this.songs, {super.key});
  String path;
  List<SongModel> songs;
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        height: height * 0.065,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (songs.isEmpty) {
                  } else {
                    BlocProvider.of<PlayerBloc>(context)
                        .add(InitPlayerEnent(songs, 0, path));
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).add(StartPlayerEnent());
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).player.setShuffleModeEnabled(false);
                  }
                },
                child: Card(
                  elevation: 2,
                  shadowColor: const Color(0xff2962FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: height * 0.045,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Play ",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (songs.isEmpty) {
                  } else {
                    BlocProvider.of<PlayerBloc>(context).add(InitPlayerEnent(
                        songs, random.nextInt(songs.length), path));
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).player.setShuffleModeEnabled(true);
                    BlocProvider.of<PlayerBloc>(
                      context,
                    ).add(StartPlayerEnent());
                  }
                },
                child: Container(
                  height: height * 0.045,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 41, 98, 255),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Shuffle ",
                          style: Theme.of(context).textTheme.labelMedium),
                      Icon(
                        Icons.shuffle,
                        color: Theme.of(context).textTheme.labelMedium!.color,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

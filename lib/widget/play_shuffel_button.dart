import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beat_wave/data/model/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaySuffelbutton extends StatelessWidget {
  PlaySuffelbutton(this.songs, {super.key});
  final List<SongModel> songs;
  final Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () async {
              if (songs.isEmpty) {
              } else {
                await PlayerAudio.setAudioSource(
                  songs,
                  random.nextInt(songs.length),
                );
                // BlocProvider.of<PlayerControllerCubit>(context).play();
                // BlocProvider.of<PlayerControllerCubit>(context).shuffle();
              }
            },
            child: Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(8),
              decoration: const ShapeDecoration(
                color: Color(0x26F4F4F4),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(
                "assets/svg/shuffle-icon.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
            )),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
            onTap: () async {
              if (songs.isEmpty) {
              } else {
                await PlayerAudio.setAudioSource(
                  songs,
                  0,
                );
              }
            },
            child: Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(5),
              decoration: const ShapeDecoration(
                color: Color(0x26F4F4F4),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(
                "assets/svg/play-album-icon.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}

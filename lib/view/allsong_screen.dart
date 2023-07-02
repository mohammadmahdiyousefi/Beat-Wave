import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/player/player.bloc.dart';
import '../bloc/player/player_event.dart';
import '../widget/song _tile.dart';

// ignore: must_be_immutable
class AllSongScreen extends StatelessWidget {
  AllSongScreen({
    super.key,
  });
  ScrollController controller = ScrollController();

  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSongsBloc, IAllSnogsState>(builder: (context, state) {
      if (state is AllSongsState) {
        return Column(
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  color: const Color(0xff212121),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<PlayerBloc>(context)
                            .add(InitPlayerEnent(state.allsongs, 0, "All"));
                        BlocProvider.of<PlayerBloc>(
                          context,
                        ).add(StartPlayerEnent());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xff2962FF),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<PlayerBloc>(context).add(
                            InitPlayerEnent(state.allsongs,
                                random.nextInt(state.allsongs.length), "All"));
                        BlocProvider.of<PlayerBloc>(
                          context,
                        ).add(ShufflePlayerEnent());
                        BlocProvider.of<PlayerBloc>(
                          context,
                        ).add(StartPlayerEnent());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(0, 41, 98, 255),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Shuffle ",
                              style: GoogleFonts.roboto(
                                  color: Color.fromARGB(255, 121, 121, 121),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            const Icon(
                              Icons.shuffle,
                              color: Color.fromARGB(255, 121, 121, 121),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimationLimiter(
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
                    itemCount: state.allsongs.length,
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
                                      InitPlayerEnent(
                                          state.allsongs, index, "All"));
                                  BlocProvider.of<PlayerBloc>(
                                    context,
                                  ).add(StartPlayerEnent());
                                },
                                child: SongTile(index, "All", state.allsongs)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

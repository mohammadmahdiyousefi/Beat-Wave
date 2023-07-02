import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';
import '../widget/artwork_widget.dart';

class ArtistScreen extends StatelessWidget {
  ArtistScreen({super.key, required this.artist});
  ScrollController scrollcontroller = ScrollController();
  List<ArtistModel> artist;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: CupertinoScrollbar(
        controller: scrollcontroller,
        thumbVisibility: true,
        thickness: 9,
        thicknessWhileDragging: 12,
        radius: const Radius.circular(10),
        child: GridView.builder(
          controller: scrollcontroller,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          physics: const BouncingScrollPhysics(),
          itemCount: artist.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: (artist.length / 2).round(),
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () async {
                      BlocProvider.of<SongBloc>(context)
                          .add(ArtistListEvent(artist[index].artist));
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SongListScreen(
                                artist[index].artist,
                                artist[index].numberOfTracks!,
                                id: artist[index].id,
                                type: ArtworkType.ARTIST,
                                nullartwork: "assets/images/artist.png",
                              )));
                    },
                    child: Container(
                      height: 160,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent),
                      child: Column(
                        children: [
                          ArtworkSong(
                            id: artist[index].id,
                            height: 130,
                            width: 130,
                            size: 300,
                            quality: 30,
                            type: ArtworkType.ARTIST,
                            nullartwork: "assets/images/artist.png",
                            radius: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                artist[index].artist.trim(),
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${artist[index].numberOfTracks} Songs'.toString(),
                            style: GoogleFonts.roboto(
                              color: Colors.grey.shade700,
                              fontSize: 9,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: () {
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// class ArtistScreen extends StatefulWidget {
//   const ArtistScreen({super.key});

//   @override
//   State<ArtistScreen> createState() => _ArtistScreenState();
// }

// class _ArtistScreenState extends State<ArtistScreen> {
//   ScrollController scrollcontroller = ScrollController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<Artistbloc>(context).add(ArtistEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(children: [
//           Expanded(
//             child: BlocBuilder<Artistbloc, IArtistState>(
//                 builder: (context, state) {
//               if (state is ArtistState) {
//                 return AnimationLimiter(
//                   child: CupertinoScrollbar(
//                     controller: scrollcontroller,
//                     thumbVisibility: true,
//                     thickness: 9,
//                     thicknessWhileDragging: 12,
//                     radius: const Radius.circular(10),
//                     child: GridView.builder(
//                       controller: scrollcontroller,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2),
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: artist.length,
//                       itemBuilder: (context, index) {
//                         return AnimationConfiguration.staggeredGrid(
//                           columnCount: (artist.length / 2).round(),
//                           position: index,
//                           duration: const Duration(milliseconds: 375),
//                           child: SlideAnimation(
//                             verticalOffset: 50.0,
//                             child: FadeInAnimation(
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   BlocProvider.of<SongBloc>(context).add(
//                                       ArtistListEvent(
//                                           artist[index].artist));
//                                   Navigator.push(
//                                       context,
//                                       PageTransition(
//                                           type: PageTransitionType.fade,
//                                           child: SongListScreen(state
//                                               .artistModel[index].artist)));
//                                 },
//                                 child: Container(
//                                   height: 160,
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 5, vertical: 5),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.transparent),
//                                   child: Column(
//                                     children: [
//                                       ArtworkSong(
//                                         id: artist[index].id,
//                                         height: 130,
//                                         width: 130,
//                                         size: 300,
//                                         quality: 30,
//                                         type: ArtworkType.ARTIST,
//                                         nullartwork: Icons.person,
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: 100,
//                                         child: Center(
//                                           child: Text(
//                                             artist[index].artist
//                                                 .trim(),
//                                             style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 10),
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         '${artist[index].numberOfTracks} Songs'
//                                             .toString(),
//                                         style: TextStyle(
//                                             color: Colors.grey.shade700,
//                                             fontSize: 9),
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 // GestureDetector(
//                                 //   onTap: () {
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             }),
//           ),
//         ]),
//       ),
//     );
//   }
// }

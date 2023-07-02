import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:justaudioplayer/widget/artwork_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import '../bloc/songlist/song_list_bloc.dart';
import '../bloc/songlist/song_list_event.dart';

class AlbumScreen extends StatelessWidget {
  AlbumScreen({super.key, required this.album});
  ScrollController scrollcontroller = ScrollController();
  List<AlbumModel> album;
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
          itemCount: album.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: (album.length / 2).round(),
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () async {
                      BlocProvider.of<SongBloc>(context)
                          .add(AlbumListEvent(album[index].id));
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SongListScreen(
                                album[index].album,
                                album[index].numOfSongs,
                                id: album[index].id,
                                type: ArtworkType.ALBUM,
                                nullartwork: "assets/images/album.png",
                              )));
                    },
                    child: Container(
                      height: 160,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.transparent),
                      child: Column(
                        children: [
                          ArtworkSong(
                            id: album[index].id,
                            height: 130,
                            width: 130,
                            size: 300,
                            quality: 25,
                            type: ArtworkType.ALBUM,
                            nullartwork: "assets/images/album.png",
                            radius: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                album[index].album.trim(),
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
                            '${album[index].numOfSongs} Songs'.toString(),
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

// class AlbumScreen extends StatefulWidget {
//   const AlbumScreen({super.key});

//   @override
//   State<AlbumScreen> createState() => _AlbumScreenState();
// }

// class _AlbumScreenState extends State<AlbumScreen> {
//   ScrollController scrollcontroller = ScrollController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<Albumbloc>(context).add(AlbumEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Column(children: [
//           Expanded(
//             child:
//                 BlocBuilder<Albumbloc, IAlbumState>(builder: (context, state) {
//               if (state is AlbumState) {
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
//                       itemCount:album.length,
//                       itemBuilder: (context, index) {
//                         return AnimationConfiguration.staggeredGrid(
//                           columnCount: (album.length / 2).round(),
//                           position: index,
//                           duration: const Duration(milliseconds: 375),
//                           child: SlideAnimation(
//                             verticalOffset: 50.0,
//                             child: FadeInAnimation(
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   BlocProvider.of<SongBloc>(context).add(
//                                       AlbumListEvent(
//                                          album[index].id));
//                                   Navigator.push(
//                                       context,
//                                       PageTransition(
//                                           type: PageTransitionType.fade,
//                                           child: SongListScreen(
//                                              album[index].album)));
//                                 },
//                                 child: Container(
//                                   height: 160,
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 5, vertical: 8),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: Colors.transparent),
//                                   child: Column(
//                                     children: [
//                                       ArtworkSong(
//                                         id:album[index].id,
//                                         height: 130,
//                                         width: 130,
//                                         size: 300,
//                                         quality: 25,
//                                         type: ArtworkType.ALBUM,
//                                         nullartwork: Icons.album,
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SizedBox(
//                                         width: 100,
//                                         child: Center(
//                                           child: Text(
//                                            album[index].album
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
//                                         '${album[index].numOfSongs} Songs'
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

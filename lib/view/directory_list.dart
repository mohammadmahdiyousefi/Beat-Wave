import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_bloc.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_event.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/bloc/player/player_event.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/player/player.bloc.dart';
import '../consts/color.dart';

class DirectoryListScreen extends StatelessWidget {
  DirectoryListScreen({super.key, required this.directrorypath});
  List<String> directrorypath;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 100),
        itemCount: directrorypath.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            columnCount: (directrorypath.length / 3).round(),
            position: index,
            duration: const Duration(milliseconds: 375),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<SongBloc>(context).add(DirectoryListEvent(
                  directrorypath[index],
                ));
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: SongListScreen(directrorypath[index],
                            int.parse(loadSongs(directrorypath[index])))));
              },
              child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    const Icon(
                      Icons.folder,
                      size: 60,
                      color: Color.fromARGB(255, 147, 147, 147),
                    ),
                    Text(
                      directrorypath[index].split('/').last,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${loadSongs(directrorypath[index])} media file",
                      style: GoogleFonts.roboto(
                        color: Colors.grey.shade700,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// class DirectoryListScreen extends StatefulWidget {
//   const DirectoryListScreen({super.key});

//   @override
//   State<DirectoryListScreen> createState() => _DirectoryListScreenState();
// }

// class _DirectoryListScreenState extends State<DirectoryListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<DirectoryListBloc>(context).add(UpdateistEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: BlocBuilder<DirectoryListBloc, IListState>(
//             builder: (context, state) {
//           if (state is ListState) {
//             return Column(children: [
//               Expanded(
//                 child: AnimationLimiter(
//                   child: GridView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3, mainAxisExtent: 100),
//                     itemCount: directrorypath.length,
//                     itemBuilder: (context, index) {
//                       return AnimationConfiguration.staggeredGrid(
//                         columnCount: (directrorypath.length / 3).round(),
//                         position: index,
//                         duration: const Duration(milliseconds: 375),
//                         child: InkWell(
//                           onTap: () {
//                             BlocProvider.of<SongBloc>(context)
//                                 .add(SongListEvent(
//                               directrorypath[index],
//                             ));
//                             Navigator.push(
//                                 context,
//                                 PageTransition(
//                                     type: PageTransitionType.fade,
//                                     child: SongListScreen(
//                                         directrorypath[index])));
//                           },
//                           child: SizedBox(
//                             height: 80,
//                             child: Column(
//                               children: [
//                                 const Icon(
//                                   Icons.folder,
//                                   size: 60,
//                                   color: Color.fromARGB(255, 147, 147, 147),
//                                 ),
//                                 Text(
//                                   directrorypath[index].split('/').last,
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   "${loadSongs(directrorypath[index])} media file",
//                                   style: TextStyle(
//                                       color: Colors.grey.shade700,
//                                       fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               )
//             ]);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         }),
//       ),
//     );
//   }

String loadSongs(String location) {
  Directory directory = Directory(location);
  return directory
      .listSync()
      .where((file) =>
          file.path.endsWith('.mp3') ||
          file.path.endsWith('.m4a') ||
          file.path.endsWith('.aac') ||
          file.path.endsWith('.ogg') ||
          file.path.endsWith('.wav'))
      .map((file) => File(file.path))
      .toList()
      .length
      .toString();
}
// }

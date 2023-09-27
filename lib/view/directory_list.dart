import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/directorylist/directory_list_bloc.dart';
import '../bloc/directorylist/directory_list_event.dart';

// ignore: must_be_immutable
class DirectoryListScreen extends StatelessWidget {
  const DirectoryListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DirectoryListBloc, IDirectoryListState>(
        builder: (context, state) {
      if (state is DirectoryListState) {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () async {
            BlocProvider.of<DirectoryListBloc>(context)
                .add(LoadDirectoryListEvent());
          },
          child: Scrollbar(
            interactive: true,
            thumbVisibility: true,
            thickness: 6,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 100),
              itemCount: state.directorylist.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      BlocProvider.of<SongBloc>(context).add(DirectoryListEvent(
                        state.directorylist[index],
                      ));
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SongListScreen(
                                  state.directorylist[index],
                                  int.parse(
                                      loadSongs(state.directorylist[index])))));
                    },
                    child: SizedBox(
                        height: 80,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.folder,
                              size: 60,
                              color: Color.fromARGB(255, 128, 128, 128),
                            ),
                            Text(state.directorylist[index].split('/').last,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${loadSongs(state.directorylist[index])} media file",
                              style: GoogleFonts.roboto(
                                color: Colors.grey.shade700,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        )));
              },
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

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

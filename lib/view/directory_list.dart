import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:justaudioplayer/view/miniplayer.dart';
import 'package:justaudioplayer/view/song_list.dart';
import 'package:justaudioplayer/widget/lodingwidget.dart';
import 'package:justaudioplayer/widget/navigator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../bloc/directorylist/directory_list_bloc.dart';
import '../bloc/directorylist/directory_list_event.dart';

class DirectoryListScreen extends StatelessWidget {
  const DirectoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Folder",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        //  bottom: customtabbar(),
      ),
      body: BlocBuilder<DirectoryListBloc, DirectoryListState>(
          builder: (context, state) {
        if (state is DirectoryList) {
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<DirectoryListBloc>(context)
                  .add(GetDirectoryList());
            },
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 6)),
                SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisExtent: 100),
                  itemCount: state.directorylist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          customNavigator(
                            context: context,
                            page: SongListScreen(
                              id: -1,
                              nullArtwork: "assets/images/song.png",
                              title: state.directorylist[index].split('/').last,
                              appbarTitle: "Folder",
                              type: ArtworkType.AUDIO,
                              path: state.directorylist[index],
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.folder,
                              size: 60,
                              color: Color.fromARGB(255, 128, 128, 128),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                  state.directorylist[index].split('/').last,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .listTileTheme
                                      .titleTextStyle),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //     "${loadSongs(state.directorylist[index])} ${loadSongs(state.directorylist[index]) <= 1 ? "song" : "songs"}",
                            //     style: Theme.of(context)
                            //         .listTileTheme
                            //         .subtitleTextStyle),
                          ],
                        ));
                  },
                ),
              ],
            ),
          );
        } else if (state is DirectoryListLoading) {
          return const Center(child: Loading());
        } else if (state is DirectoryListEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/error-icon.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.empty,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        } else if (state is DirectoryListError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/error-icon.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  state.error,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      BlocProvider.of<DirectoryListBloc>(context)
                          .add(GetDirectoryList());
                    },
                    child: Text(
                      "Try again",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/error-icon.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "An unknown error occurred while loading folders",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      BlocProvider.of<DirectoryListBloc>(context)
                          .add(GetDirectoryList());
                    },
                    child: Text(
                      "Try again",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ],
            ),
          );
        }
      }),
    );
  }
}

int loadSongs(String location) {
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
      .length;
}

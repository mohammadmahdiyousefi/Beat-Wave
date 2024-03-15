import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/directorylist/directory_list_state.dart';
import 'package:beat_wave/view/miniplayer.dart';
import 'package:beat_wave/view/song_list.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:beat_wave/widget/navigator.dart';
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
                  SliverList.builder(
                    itemCount: state.directorylist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 7),
                          horizontalTitleGap: 7,
                          onTap: () {
                            customNavigator(
                              context: context,
                              page: SongListScreen(
                                id: -1,
                                nullArtwork: "assets/images/song.png",
                                title:
                                    state.directorylist[index].split('/').last,
                                appbarTitle: "Folder",
                                type: ArtworkType.AUDIO,
                                path: state.directorylist[index],
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.folder,
                            size: 60,
                            color: Color.fromARGB(255, 128, 128, 128),
                          ),
                          title: Text(
                              state.directorylist[index].split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .listTileTheme
                                  .titleTextStyle),
                          subtitle: Text(state.directorylist[index],
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .listTileTheme
                                  .subtitleTextStyle),
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 70)),
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
                    style: Theme.of(context).textTheme.bodySmall,
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<DirectoryListBloc>(context)
                            .add(GetDirectoryList());
                      },
                      child: const Text(
                        "Try again",
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
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<DirectoryListBloc>(context)
                            .add(GetDirectoryList());
                      },
                      child: const Text(
                        "Try again",
                      )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

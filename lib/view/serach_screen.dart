import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justaudioplayer/bloc/search/search_song_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:justaudioplayer/data/model/player.dart';
import 'package:justaudioplayer/widget/lodingwidget.dart';
import 'package:justaudioplayer/widget/song_more.dart';
import 'package:justaudioplayer/widget/song_tile.dart';
import '../bloc/search/search_song_event.dart';
import 'miniplayer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var searchbloc = Searchbloc();
        searchbloc.add(const SearchSong(""));
        return searchbloc;
      },
      child: SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  SearchView({
    super.key,
  });

  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: Miniplayer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          shadowColor: Theme.of(context).shadowColor,
          iconTheme: Theme.of(context).iconTheme,
          actions: const [
            SizedBox(
              width: 16,
            )
          ],
          leading: Builder(builder: (context) {
            return IconButton(
                splashRadius: 15,
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new));
          }),
          title: TextField(
              autofocus: true,
              onChanged: (value) {
                BlocProvider.of<Searchbloc>(context).add(SearchSong(value));
              },
              decoration: InputDecoration(
                hintText: "Search songs",
                isDense: true, // Added this
                contentPadding: const EdgeInsets.all(6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.6),
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 45, maxWidth: 45),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(11),
                  child: SvgPicture.asset(
                    "assets/svg/Search.svg",
                    height: 16,
                    width: 16,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              )),
        ),
        body:
            BlocBuilder<Searchbloc, SearchSongState>(builder: (context, state) {
          if (state is SearchSongList) {
            return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      return SongTile(
                        song: state.songs[index],
                        onTap: () async {
                          await PlayerAudio.setAudioSource(
                            state.songs,
                            index,
                          );
                        },
                        moreOnTap: () async {
                          await moreBottomSheet(context, state.songs[index]);
                        },
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 70),
                  )
                ]);
          } else if (state is SearchSongEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else if (state is SearchSongError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      BlocProvider.of<Searchbloc>(context)
                          .add(SearchSong(text.text));
                    },
                    child: const Text(
                      "Try again",
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SearchSongLoading) {
            return const Loading();
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    "An unknown error occurred",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<Searchbloc>(context)
                            .add(SearchSong(text.text));
                      },
                      child: const Text(
                        "Try again",
                      )),
                ],
              ),
            );
          }
        }));
  }
}

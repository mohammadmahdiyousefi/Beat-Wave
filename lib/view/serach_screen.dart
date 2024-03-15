import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/widget/bottomsheet/bottom_sheet_item.dart';
import 'package:beat_wave/widget/favorit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/bloc/search/search_song_bloc.dart';
import 'package:beat_wave/bloc/search/search_song_state.dart';
import 'package:beat_wave/service/player_service/player.dart';
import 'package:beat_wave/widget/lodingwidget.dart';
import 'package:beat_wave/widget/bottomsheet/song_more.dart';
import 'package:beat_wave/widget/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
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
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Miniplayer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
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
              fillColor:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
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
      body: BlocBuilder<Searchbloc, SearchSongState>(
        builder: (context, state) {
          if (state is SearchSongList) {
            return CustomScrollView(
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
                        await moreBottomSheet(
                          context,
                          ListTile(
                            shape: Theme.of(context).listTileTheme.shape,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 7),
                            title: Text(state.songs[index].title),
                            titleTextStyle:
                                Theme.of(context).listTileTheme.titleTextStyle,
                            subtitle:
                                Text(state.songs[index].artist ?? "<unkown>"),
                            subtitleTextStyle: Theme.of(context)
                                .listTileTheme
                                .subtitleTextStyle,
                            trailing: FavoritButton(
                              song: state.songs[index],
                              color: Theme.of(context).iconTheme.color ??
                                  Colors.grey,
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/cover.jpg"))),
                              child: QueryArtworkWidget(
                                id: state.songs[index].id,
                                quality: 50,
                                size: 200,
                                controller: onAudioQuery,
                                format: ArtworkFormat.JPEG,
                                type: ArtworkType.AUDIO,
                                keepOldArtwork: false,
                                artworkBorder: BorderRadius.circular(6),
                                artworkQuality: FilterQuality.low,
                                artworkFit: BoxFit.fill,
                                artworkHeight: 50,
                                artworkWidth: 50,
                                nullArtworkWidget: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/cover.jpg",
                                        ),
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.cover),
                                    color:
                                        const Color.fromARGB(255, 61, 60, 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          songItems(context, state.songs[index]),
                        );
                      },
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),
              ],
            );
          } else if (state is SearchSongEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
        },
      ),
    );
  }
}

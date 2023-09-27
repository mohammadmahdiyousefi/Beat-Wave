import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/search/search_song_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:justaudioplayer/widget/song%20_tile.dart';
import '../bloc/search/search_song-event.dart';
import 'darwer.dart';
import 'miniplayer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const Drawerscreen(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: Theme.of(context).iconTheme,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  splashRadius: 20,
                ),
              ],
              title: SizedBox(
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    BlocProvider.of<Searchbloc>(context)
                        .add(SearchSongEvent(value));
                  },
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                      hintText: "search",
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<Searchbloc, ISearchSongState>(
                      builder: (context, state) {
                    if (state is SearchSongState) {
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            itemCount: state.songs.length,
                            itemBuilder: (context, index) {
                              return SongTile(
                                  index, "search", state.songs, false);
                            },
                          ))
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
                Miniplayer(),
              ],
            )));
  }
}

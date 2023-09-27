import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song-event.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Searchbloc extends Bloc<ISearchSongEvent, ISearchSongState> {
  OnAudioQuery listsong = OnAudioQuery();
  List<SongModel> newlist = [];
  Searchbloc(super.initialState) {
    on<SearchSongEvent>((event, emit) async {
      emit(InitSearchState());
      newlist = await listsong.querySongs();
      newlist = newlist
          .where((element) => element.displayName
              .toLowerCase()
              .contains(event.songtitel.toLowerCase()))
          .toList();
      emit(SearchSongState(newlist));
    });
  }
}

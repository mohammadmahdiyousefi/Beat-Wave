import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song_event.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/repository/localrepository/searchsongrepository.dart';

class Searchbloc extends Bloc<SearchSongEvent, SearchSongState> {
  final ISearchsongRepository _repository = locator.get();
  Searchbloc() : super(const SearchSongLoading()) {
    on<SearchSong>((event, emit) async {
      emit(const SearchSongLoading());
      if (event.songtitel.isEmpty) {
        emit(const SearchSongList([]));
      } else {
        var songrespons =
            await _repository.getsearchsongrepository(event.songtitel);
        songrespons.fold((error) {
          emit(const SearchSongError("Error in music search"));
        }, (newlist) {
          if (newlist.isEmpty) {
            emit(SearchSongEmpty(
                "Unfortunately, no music was found with the title  ' ${event.songtitel} '"));
          } else {
            emit(SearchSongList(newlist));
          }
        });
      }
    });
  }
}

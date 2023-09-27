import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/search/search_song-event.dart';
import 'package:justaudioplayer/bloc/search/search_song_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/repository/localrepository/searchsongrepository.dart';

class Searchbloc extends Bloc<ISearchSongEvent, ISearchSongState> {
  final ISearchsongRepository _repository = locator.get();
  Searchbloc(super.initialState) {
    on<SearchSongEvent>((event, emit) async {
      emit(InitSearchState());
      var songrespons =
          await _repository.getsearchsongrepository(event.songtitel);
      songrespons.fold((error) {
        emit(ErrorSearchState(error));
      }, (newlist) {
        emit(SearchSongState(newlist));
      });
    });
  }
}

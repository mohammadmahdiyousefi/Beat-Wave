import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/repository/localrepository/songrepository.dart';

class SongBloc extends Bloc<SongListEvent, SongListState> {
  final ISongRepository _repository = locator.get();
  SongBloc() : super(const SongListLoading()) {
    on<GetSongListEvent>((event, emit) async {
      emit(const SongListLoading());
      if (event.path == null && event.type != null) {
        var songrespons =
            await _repository.getSongRepository(event.id, event.type!);
        songrespons.fold((error) {
          emit(const SongListError("Error loading music"));
        }, (song) {
          if (song.isEmpty) {
            emit(const SongListEmpty("Unfortunately, no music was found"));
          } else {
            emit(SongList(song));
          }
        });
      } else if (event.path != null && event.type == null) {
        var songrespons =
            await _repository.getFromFoldersongRepository(event.path!);
        songrespons.fold((error) {
          emit(const SongListError("Error loading music"));
        }, (song) {
          if (song.isEmpty) {
            emit(const SongListEmpty("Unfortunately, no music was found"));
          } else {
            emit(SongList(song));
          }
        });
      } else {
        emit(const SongListError("Error loading music"));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/repository/localrepository/playlistrepository.dart';

class PlaylistBloc extends Bloc<IPlaylistEvent, PlaylistState> {
  final IPlaylistRepository _repository = locator.get();
  PlaylistBloc() : super(PlayListLoading()) {
    on<GetPlaylistEvent>((event, emit) async {
      emit(PlayListLoading());
      var plailist = await _repository.getPlaylistrepository();
      plailist.fold((error) {
        emit(const PlayListError("Error loading playlist"));
      }, (list) {
        if (list.isEmpty) {
          emit(const PlayListEmpty("Unfortunately, no playlist was found"));
        } else {
          emit(PlayList(list));
        }
      });
    });
  }
}

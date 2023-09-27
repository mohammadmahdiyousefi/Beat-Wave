import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_event.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/repository/localrepository/albumrepository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumBloc extends Bloc<IAlbumEvent, IAlbumState> {
  final IAlbumRepository _repository = locator.get();
  AlbumBloc(super.initialState) {
    on<AlbumEvent>((event, emit) async {
      emit(LoadAlbumState());
      var albumrespons = await _repository.getalbumrepository();
      albumrespons.fold((error) {
        emit(AlbumErrorState(error));
      }, (album) {
        emit(AlbumState(album));
      });
    });
  }
}

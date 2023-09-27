import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_event.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumBloc extends Bloc<IAlbumEvent, IAlbumState> {
  AlbumBloc(super.initialState) {
    final OnAudioQuery album = OnAudioQuery();
    late List<AlbumModel> albums;
    on<AlbumEvent>((event, emit) async {
      emit(InitAlbumState());
      albums = await album.queryAlbums();
      emit(AlbumState(albums));
    });
  }
}

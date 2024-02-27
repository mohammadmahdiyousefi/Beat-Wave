import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beat_wave/bloc/album/album_event.dart';
import 'package:beat_wave/bloc/album/album_state.dart';
import 'package:beat_wave/di/di.dart';
import 'package:beat_wave/data/repository/localrepository/albumrepository.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final IAlbumRepository _repository = locator.get();
  AlbumBloc() : super(const AlbumLoading()) {
    on<GetAlbumEvent>((event, emit) async {
      emit(const AlbumLoading());
      var albumrespons = await _repository.getAlbumRepository();
      albumrespons.fold((error) {
        emit(const AlbumError("Error loading albums"));
      }, (album) {
        if (album.isEmpty) {
          emit(const AlbumEmpty("Unfortunately, no album was found"));
        } else {
          emit(AlbumList(album));
        }
      });
    });
  }
}

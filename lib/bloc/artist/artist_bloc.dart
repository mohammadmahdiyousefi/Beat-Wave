import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_event.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/repository/localrepository/artistrepository.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'artist_event.dart';
import 'artist_state.dart';

class ArtistBloc extends Bloc<IArtistEvent, IArtistState> {
  final IArtistRepository _repository = locator.get();
  ArtistBloc(super.initialState) {
    on<ArtistEvent>((event, emit) async {
      emit(LoadArtistState());
      var artistrespons = await _repository.getartistrepository();
      artistrespons.fold((error) {
        emit(ArtistErrorState(error));
      }, (artist) {
        emit(ArtistState(artist));
      });
    });
  }
}

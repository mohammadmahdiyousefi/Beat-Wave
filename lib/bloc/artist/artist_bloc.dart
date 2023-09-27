import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/album/album_event.dart';
import 'package:justaudioplayer/bloc/album/album_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'artist_event.dart';
import 'artist_state.dart';

class ArtistBloc extends Bloc<IArtistEvent, IArtistState> {
  ArtistBloc(super.initialState) {
    final OnAudioQuery artist = OnAudioQuery();
    late List<ArtistModel> artists;
    on<ArtistEvent>((event, emit) async {
      emit(InitArtistState());
      artists = await artist.queryArtists();
      emit(ArtistState(artists));
    });
  }
}

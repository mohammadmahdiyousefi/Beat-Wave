import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_event.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsBloc extends Bloc<IAllSongsEvent, IAllSnogsState> {
  final OnAudioQuery _allsongs = OnAudioQuery();
  late List<SongModel> allsongs;
  AllSongsBloc(super.initialState) {
    on<AllSongsEvent>((event, emit) async {
      emit(InitAllSongs());
      allsongs = await _allsongs.querySongs();
      emit(AllSongsState(allsongs));
    });
  }
}

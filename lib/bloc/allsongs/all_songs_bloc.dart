import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_event.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/repository/localrepository/allsongrepository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsBloc extends Bloc<IAllSongsEvent, IAllSnogsState> {
  final IAllsongRepository _repository = locator.get();
  AllSongsBloc(super.initialState) {
    on<AllSongsEvent>((event, emit) async {
      emit(LoadAllsong());
      var songrespons = await _repository.getallsongrepository();
      songrespons.fold((error) {
        emit(AllsongError(error));
      }, (songs) {
        emit(AllSongsState(songs));
      });
    });
  }
}

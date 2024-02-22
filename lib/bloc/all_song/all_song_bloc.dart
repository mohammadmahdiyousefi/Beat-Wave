import 'package:bloc/bloc.dart';
import 'package:justaudioplayer/bloc/all_song/all_song_event.dart';
import 'package:justaudioplayer/bloc/all_song/all_song_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/repository/localrepository/songrepository.dart';

class AllSongBloc extends Bloc<AllSongEvent, AllSongState> {
  final ISongRepository _repository = locator.get();
  AllSongBloc() : super(const AllSongLoading()) {
    on<GetAllSong>((event, emit) async {
      emit(const AllSongLoading());
      var songrespons = await _repository.getAllSongRepository();
      songrespons.fold((error) {
        emit(const AllSongError("Error loading music"));
      }, (song) {
        if (song.isEmpty) {
          emit(const AllSongEmpty("Unfortunately, no music was found"));
        } else {
          emit(AllSongList(song));
        }
      });
    });
  }
}

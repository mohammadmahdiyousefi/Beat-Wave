import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/data/repository/localrepository/artistrepository.dart';
import 'artist_event.dart';
import 'artist_state.dart';

class ArtistBloc extends Bloc<IArtistEvent, ArtistState> {
  final IArtistRepository _repository = locator.get();
  ArtistBloc() : super(const ArtistLoading()) {
    on<GetArtistEvent>((event, emit) async {
      emit(const ArtistLoading());
      var artistrespons = await _repository.getArtistRepository();
      artistrespons.fold((error) {
        emit(const ArtistError("Error loading artists"));
      }, (artist) {
        if (artist.isEmpty) {
          emit(const ArtistEmpty("Unfortunately, no artist was found"));
        } else {
          emit(ArtistList(artist));
        }
      });
    });
  }
}

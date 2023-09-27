import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistState {}

class InitArtistState extends IArtistState {}

class LoadArtistState extends IArtistState {}

class ArtistState extends IArtistState {
  List<ArtistModel> artists;
  ArtistState(this.artists);
}

class ArtistErrorState extends IArtistState {
  String error;
  ArtistErrorState(this.error);
}

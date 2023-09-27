import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistState {}

class InitArtistState extends IArtistState {}

class ArtistState extends IArtistState {
  List<ArtistModel> artists;
  ArtistState(this.artists);
}

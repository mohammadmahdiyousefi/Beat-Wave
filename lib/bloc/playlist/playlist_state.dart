import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlaylistState {}

class PlaylistInitState extends IPlaylistState {}

class PlaylistState extends IPlaylistState {
  List<PlaylistModel> playlist;
  PlaylistState(this.playlist);
}

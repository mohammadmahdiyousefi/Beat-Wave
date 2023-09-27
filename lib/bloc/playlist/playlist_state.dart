import 'package:justaudioplayer/model/playlist.dart';

abstract class IPlaylistState {}

class PlaylistInitState extends IPlaylistState {}

class PlaylistState extends IPlaylistState {
  List<Playlist> playlist;
  PlaylistState(
    this.playlist,
  );
}

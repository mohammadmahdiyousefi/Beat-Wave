import 'package:justaudioplayer/model/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlaylistEvent {}

class PlaylistEvent extends IPlaylistEvent {}

class CreatPlaylistEvent extends IPlaylistEvent {
  String playlistname;
  CreatPlaylistEvent(this.playlistname);
}

class RemovePlaylistEvent extends IPlaylistEvent {
  String playlistname;
  RemovePlaylistEvent(this.playlistname);
}

class RemoveFromPlaylistEvent extends IPlaylistEvent {
  String name;
  String song;
  RemoveFromPlaylistEvent(this.name, this.song);
}

class EditPlaylistEvent extends IPlaylistEvent {
  int? imageid;
  String playlistname;
  String newplaylistname;
  EditPlaylistEvent(this.imageid, this.playlistname, this.newplaylistname);
}

class AddRemovetoPlaylistEvent extends IPlaylistEvent {
  Playlist item;
  SongModel song;
  AddRemovetoPlaylistEvent(this.song, this.item);
}

class AddPlaylistScreenEvent extends IPlaylistEvent {
  SongModel song;
  AddPlaylistScreenEvent(this.song);
}

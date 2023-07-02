abstract class IPlaylistEvent {}

class PlaylistEvent extends IPlaylistEvent {}

class CreatPlaylistEvent extends IPlaylistEvent {
  String playlistname;
  CreatPlaylistEvent(this.playlistname);
}

class RemovePlaylistEvent extends IPlaylistEvent {
  int playlistid;
  RemovePlaylistEvent(this.playlistid);
}

class EditPlaylistEvent extends IPlaylistEvent {
  int playlistid;
  String playlistname;
  EditPlaylistEvent(this.playlistid, this.playlistname);
}

class AddtoPlaylistEvent extends IPlaylistEvent {
  int playlistid;
  int musicid;
  AddtoPlaylistEvent(this.playlistid, this.musicid);
}

import 'package:on_audio_query/on_audio_query.dart';

abstract class ISongListEvent {}

class SongListEvent extends ISongListEvent {
  String directorypath;

  SongListEvent(this.directorypath);
}

class ArtistListEvent extends ISongListEvent {
  String artist;

  ArtistListEvent(this.artist);
}

class PlasyListEvent extends ISongListEvent {
  String playlist;

  PlasyListEvent(this.playlist);
}

class AlbumListEvent extends ISongListEvent {
  int albumId;

  AlbumListEvent(this.albumId);
}

class DirectoryListEvent extends ISongListEvent {
  String path;

  DirectoryListEvent(this.path);
}

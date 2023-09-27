import 'package:on_audio_query/on_audio_query.dart';

abstract class IAlbumState {}

class InitAlbumState extends IAlbumState {}

class LoadAlbumState extends IAlbumState {}

class AlbumState extends IAlbumState {
  List<AlbumModel> albums;
  AlbumState(this.albums);
}

class AlbumErrorState extends IAlbumState {
  String error;
  AlbumErrorState(this.error);
}

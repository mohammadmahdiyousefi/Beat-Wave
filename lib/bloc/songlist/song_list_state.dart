import 'package:on_audio_query/on_audio_query.dart';

abstract class ISongListState {}

class LoadSongListState extends ISongListState {}

class SongListState extends ISongListState {
  List<SongModel> songs;

  SongListState(this.songs);
}

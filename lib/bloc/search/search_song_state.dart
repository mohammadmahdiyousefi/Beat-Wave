import 'package:on_audio_query/on_audio_query.dart';

abstract class ISearchSongState {}

class InitSearchState extends ISearchSongState {}

class SearchSongState extends ISearchSongState {
  List<SongModel> songs;
  SearchSongState(this.songs);
}

class ErrorSearchState extends ISearchSongState {
  String error;
  ErrorSearchState(this.error);
}

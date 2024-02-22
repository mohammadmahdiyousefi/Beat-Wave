import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SearchSongState extends Equatable {
  const SearchSongState();
  @override
  List<Object> get props => [];
}

class SearchSongLoading extends SearchSongState {
  const SearchSongLoading();
  @override
  List<Object> get props => [];
}

class SearchSongList extends SearchSongState {
  final List<SongModel> songs;
  const SearchSongList(this.songs);
  @override
  List<Object> get props => [songs];
}

class SearchSongEmpty extends SearchSongState {
  final String empty;
  const SearchSongEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

class SearchSongError extends SearchSongState {
  final String error;
  const SearchSongError(this.error);
  @override
  List<Object> get props => [error];
}

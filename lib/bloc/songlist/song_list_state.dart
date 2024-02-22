import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongListState extends Equatable {
  const SongListState();
  @override
  List<Object> get props => [];
}

final class SongListLoading extends SongListState {
  const SongListLoading();
  @override
  List<Object> get props => [];
}

final class SongList extends SongListState {
  final List<SongModel> songs;
  const SongList(this.songs);
  @override
  List<Object> get props => [songs];
}

final class SongListEmpty extends SongListState {
  final String empty;
  const SongListEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class SongListError extends SongListState {
  final String error;
  const SongListError(this.error);
  @override
  List<Object> get props => [error];
}

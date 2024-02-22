import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class AllSongState extends Equatable {
  const AllSongState();
  @override
  List<Object> get props => [];
}

final class AllSongLoading extends AllSongState {
  const AllSongLoading();
  @override
  List<Object> get props => [];
}

final class AllSongList extends AllSongState {
  final List<SongModel> songs;
  const AllSongList(this.songs);
  @override
  List<Object> get props => [songs];
}

final class AllSongEmpty extends AllSongState {
  final String empty;
  const AllSongEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class AllSongError extends AllSongState {
  final String error;
  const AllSongError(this.error);
  @override
  List<Object> get props => [error];
}

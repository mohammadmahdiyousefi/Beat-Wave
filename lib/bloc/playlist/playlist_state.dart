import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();
  @override
  List<Object> get props => [];
}

final class PlayListLoading extends PlaylistState {}

final class PlayList extends PlaylistState {
  final List<PlaylistModel> playlist;
  const PlayList(this.playlist);
  @override
  List<Object> get props => [];
}

final class PlayListEmpty extends PlaylistState {
  final String empty;
  const PlayListEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class PlayListError extends PlaylistState {
  final String error;
  const PlayListError(this.error);
  @override
  List<Object> get props => [error];
}

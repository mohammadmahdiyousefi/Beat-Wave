import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();
  @override
  List<Object> get props => [];
}

final class AlbumLoading extends AlbumState {
  const AlbumLoading();
  @override
  List<Object> get props => [];
}

final class AlbumList extends AlbumState {
  final List<AlbumModel> albums;
  const AlbumList(this.albums);
  @override
  List<Object> get props => [albums];
}

final class AlbumEmpty extends AlbumState {
  final String empty;
  const AlbumEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class AlbumError extends AlbumState {
  final String error;
  const AlbumError(this.error);
  @override
  List<Object> get props => [error];
}

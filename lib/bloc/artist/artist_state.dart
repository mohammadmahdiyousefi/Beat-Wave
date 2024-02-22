import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ArtistState extends Equatable {
  const ArtistState();
  @override
  List<Object> get props => [];
}

final class ArtistLoading extends ArtistState {
  const ArtistLoading();
  @override
  List<Object> get props => [];
}

final class ArtistList extends ArtistState {
  final List<ArtistModel> artists;
  const ArtistList(this.artists);
  @override
  List<Object> get props => [artists];
}

final class ArtistEmpty extends ArtistState {
  final String empty;
  const ArtistEmpty(this.empty);
  @override
  List<Object> get props => [empty];
}

final class ArtistError extends ArtistState {
  final String error;
  const ArtistError(this.error);
  @override
  List<Object> get props => [error];
}

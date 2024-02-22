import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSongListEvent extends SongListEvent {
  final AudiosFromType? type;
  final int id;
  final String? path;
  GetSongListEvent(this.id, this.type, this.path);
  @override
  List<Object> get props => [id];
}

class DeletSongEvent extends SongListEvent {
  final SongModel song;
  DeletSongEvent(this.song);
}

import 'package:equatable/equatable.dart';

abstract class SearchSongEvent extends Equatable {
  const SearchSongEvent();
  @override
  List<Object> get props => [];
}

class SearchSong extends SearchSongEvent {
  final String songtitel;
  const SearchSong(this.songtitel);
  @override
  List<Object> get props => [songtitel];
}

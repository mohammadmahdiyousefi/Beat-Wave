abstract class ISearchSongEvent {}

class InitSearchEvent extends ISearchSongEvent {}

class SearchSongEvent extends ISearchSongEvent {
  String songtitel;
  SearchSongEvent(this.songtitel);
}

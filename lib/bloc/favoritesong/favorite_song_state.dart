import 'package:on_audio_query/on_audio_query.dart';

abstract class IFavoriteSongsState {}

class InitFavoritSongs extends IFavoriteSongsState {}

class FavoriteSongsstete extends IFavoriteSongsState {
  List<SongModel> favoriteSongs;
  FavoriteSongsstete(this.favoriteSongs);
}

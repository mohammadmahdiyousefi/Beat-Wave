import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IMainScreenState {}

class InitMainScreenState extends IMainScreenState {}

class MainScreenState extends IMainScreenState {}

class AllSongScreenState extends IMainScreenState {
  List<SongModel> allsongs;
  AllSongScreenState(this.allsongs);
}

class AlbumScreenState extends IMainScreenState {
  List<AlbumModel> albumsong;
  AlbumScreenState(this.albumsong);
}

class ArtistScreenState extends IMainScreenState {
  List<ArtistModel> artistsong;
  ArtistScreenState(this.artistsong);
}

class PlaylistScreenState extends IMainScreenState {
  PlaylistScreenState();
}

class FavoritScreenState extends IMainScreenState {}

class DirectoryScreenState extends IMainScreenState {
  List<String> directorylist;
  DirectoryScreenState(this.directorylist);
}

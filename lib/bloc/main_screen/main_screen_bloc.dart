import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'main_screen_envent.dart';
import 'main_screen_state.dart';

class MainScreenbloc extends Bloc<IMainScreenEvent, IMainScreenState> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late List<SongModel> _songs;
  late List<AlbumModel> _albumsong;
  late List<ArtistModel> _artistsong;

  List<String> directoryPaths = [];
  MainScreenbloc(super.initialState) {
    on<AllSongScreenEvent>((event, emit) async {
      emit(InitMainScreenState());
      _songs = await _audioQuery.querySongs();
      emit(AllSongScreenState(_songs));
    });
    on<ArtistScreenEvent>((event, emit) async {
      emit(InitMainScreenState());
      _artistsong = await _audioQuery.queryArtists();
      emit(ArtistScreenState(_artistsong));
    });
    on<AlbumScreenEvent>((event, emit) async {
      emit(InitMainScreenState());
      _albumsong = await _audioQuery.queryAlbums();
      emit(AlbumScreenState(_albumsong));
    });
    on<DirectoryScreenEvent>((event, emit) async {
      emit(InitMainScreenState());
      directoryPaths.clear();
      await loaddirectory();
      emit(DirectoryScreenState(directoryPaths));
    });
    on<FavoritScreenEvent>((event, emit) async {
      emit(FavoritScreenState());
    });
    on<PlaylistScreenEvent>((event, emit) async {
      emit(PlaylistScreenState());
    });
  }
  Future<void> loaddirectory() async {
    _songs = await _audioQuery.querySongs();
    for (var song in _songs) {
      if (directoryPaths
              .contains(song.data.substring(0, song.data.lastIndexOf("/"))) ==
          false) {
        directoryPaths.add(song.data.substring(0, song.data.lastIndexOf("/")));
      }
    }
    directoryPaths.sort();
  }
}

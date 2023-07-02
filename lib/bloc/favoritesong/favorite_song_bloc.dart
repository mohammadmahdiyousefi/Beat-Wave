import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/bloc/favoritesong/favorite_song_event.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'favorite_song_state.dart';

class FavoritSongBloc extends Bloc<IFavoriteSongeEvent, IFavoriteSongsState> {
  List<SongModel> favorite = [];
  final box = Hive.box('FavoriteSongs');
  FavoritSongBloc(super.initialState) {
    on<FavoriteSongeEvent>((event, emit) async {
      emit(InitFavoritSongs());
      await loadSongList();
      emit(FavoriteSongsstete(favorite));
    });
    on<AddFavoriteSongeEvent>((event, emit) async {
      emit(InitFavoritSongs());
      await saveSongList(event.favoritesong);
      await loadSongList();
      emit(FavoriteSongsstete(favorite));
    });
    on<DeleteFavoriteSongeEvent>((event, emit) async {
      emit(InitFavoritSongs());
      box.deleteAt(box.values.toList().indexOf(event.favoritesong));
      await loadSongList();
      emit(FavoriteSongsstete(favorite));
    });
  }
  Future<void> saveSongList(String song) async {
    await box.add(song);
  }

  Future<void> loadSongList() async {
    favorite.clear();
    for (var song in box.values.toList()) {
      dynamic decodedJson = jsonDecode(song);
      SongModel audio = SongModel(decodedJson);
      favorite.add(audio);
    }
  }
}

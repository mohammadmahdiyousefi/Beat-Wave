import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:justaudioplayer/model/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistBloc extends Bloc<IPlaylistEvent, IPlaylistState> {
  List<int> playlistid = [];
  List<String> songs = [];
  var playlistbox = Hive.box<Playlist>("playlist");
  PlaylistBloc(super.initialState) {
    on<PlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      emit(PlaylistState(playlistbox.values.toList()));
    });
    on<CreatPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      if (playlistbox.get(event.playlistname) == null) {
        await playlistbox.put(
            event.playlistname, Playlist(name: event.playlistname, songs: []));
      }
      emit(PlaylistState(playlistbox.values.toList()));
    });
    on<RemovePlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      await playlistbox.delete(event.playlistname);
      emit(PlaylistState(playlistbox.values.toList()));
    });
    on<EditPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      songs = playlistbox.get(event.playlistname)!.songs;
      await playlistbox.delete(event.playlistname);
      playlistbox.put(
          event.newplaylistname,
          Playlist(
              name: event.newplaylistname,
              imageid: event.imageid ?? SongModel(jsonDecode(songs[0])).id,
              songs: songs));
      emit(PlaylistState(playlistbox.values.toList()));
    });
    on<AddRemovetoPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      String song = jsonEncode(event.song.getMap);
      songs = playlistbox.get(event.item.name)!.songs;
      if (songs.contains(song) == false) {
        songs.add(song);
      } else {
        songs.remove(song);
      }
      playlistbox.put(
          event.item.name,
          Playlist(
              name: event.item.name,
              imageid: event.item.imageid ?? SongModel(jsonDecode(songs[0])).id,
              songs: songs));

      emit(PlaylistState(playlistbox.values.toList()));
    });
    on<RemoveFromPlaylistEvent>((event, emit) async {});
    on<AddPlaylistScreenEvent>((event, emit) async {
      emit(PlaylistState(playlistbox.values.toList()));
    });
  }
}

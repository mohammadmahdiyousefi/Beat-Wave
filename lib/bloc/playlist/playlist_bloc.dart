import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistBloc extends Bloc<IPlaylistEvent, IPlaylistState> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  late List<PlaylistModel> playlist;
  PlaylistBloc(super.initialState) {
    on<PlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      await loadplaylist();
      emit(PlaylistState(playlist));
    });
    on<CreatPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      creatplaylist(event.playlistname);
      await loadplaylist();
      emit(PlaylistState(playlist));
    });
    on<RemovePlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      await removeplaylist(event.playlistid);
      await loadplaylist();
      emit(PlaylistState(playlist));
    });
    on<EditPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      editplaylist(event.playlistid, event.playlistname);
      await loadplaylist();
      emit(PlaylistState(playlist));
    });
    on<AddtoPlaylistEvent>((event, emit) async {
      emit(PlaylistInitState());
      addtoplaylist(event.playlistid, event.musicid);
      await loadplaylist();
      emit(PlaylistState(playlist));
    });
  }
  Future loadplaylist() async {
    playlist = await _audioQuery.queryPlaylists();
  }

  Future removeplaylist(int playlistid) async {
    await _audioQuery.removePlaylist(playlistid);
  }

  Future creatplaylist(String name) async {
    await _audioQuery.createPlaylist(name);
  }

  Future editplaylist(int playlistid, String name) async {
    await _audioQuery.renamePlaylist(playlistid, name);
  }

  Future addtoplaylist(int playlistId, int audioId) async {
    await _audioQuery.addToPlaylist(playlistId, audioId);
  }
}

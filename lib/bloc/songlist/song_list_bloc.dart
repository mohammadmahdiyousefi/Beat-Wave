import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongBloc extends Bloc<ISongListEvent, ISongListState> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  SongBloc(super.initialState) {
    on<SongListEvent>((event, emit) async {
      emit(LoadSongListState());
      await loadmusiclist(event.directorypath);
      emit(SongListState(songs));
    });
    on<ArtistListEvent>((event, emit) async {
      emit(LoadSongListState());
      await loadArtistmusiclist(
        event.artist,
      );
      emit(SongListState(songs));
    });
    on<AlbumListEvent>((event, emit) async {
      emit(LoadSongListState());
      await loadAlbummusiclist(event.albumId);
      emit(SongListState(songs));
    });
    on<PlasyListEvent>((event, emit) async {
      emit(LoadSongListState());
      await loadPlaylistmusiclist(event.playlist);
      emit(SongListState(
        songs,
      ));
    });
    on<DirectoryListEvent>((event, emit) async {
      emit(LoadSongListState());
      await loadmusiclist(event.path);
      emit(SongListState(
        songs,
      ));
    });
  }
  Future<void> loadmusiclist(String path) async {
    songs.clear();
    songs = await _audioQuery.querySongs(path: path);
    songs = songs
        .where((track) =>
            track.data.substring(0, track.data.lastIndexOf("/")) == path)
        .map((file) => SongModel(file.getMap))
        .toList();
  }

  // Future<void> loadAllmusiclist() async {
  //   songs.clear();
  //   songs = await _audioQuery.querySongs();
  //   songs = songs
  //       .where((track) => track.data.contains("Android") == false)
  //       .map((track) => SongModel(track.getMap))
  //       .toList();
  // }

  Future<void> loadArtistmusiclist(String artist) async {
    songs.clear();
    songs = await _audioQuery.querySongs();
    songs = songs
        .where((track) => track.artist == artist)
        .map((track) => SongModel(track.getMap))
        .toList();
  }

  Future<void> loadPlaylistmusiclist(String playlist) async {
    songs.clear();
    songs =
        await _audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, playlist);
    // songs = await _audioQuery.queryFromFolder(path);
    // songs = songs
    //     .where((track) => track.artist == playlist)
    //     .map((track) => SongModel(track.getMap))
    //     .toList();
  }

  Future<void> loadAlbummusiclist(int albumId) async {
    songs.clear();
    songs = await _audioQuery.querySongs();
    songs = songs
        .where((track) => track.albumId == albumId)
        .map((track) => SongModel(track.getMap))
        .toList();
  }
}

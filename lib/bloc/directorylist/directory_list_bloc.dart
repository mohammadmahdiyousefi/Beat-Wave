import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_event.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryListBloc extends Bloc<IDirectoryListEvent, IDirectoryListState> {
  List<String> directoryPaths = [];
  OnAudioQuery audioQuery = OnAudioQuery();
  late List<SongModel> songs = [];
  DirectoryListBloc(super.initialState) {
    on<LoadDirectoryListEvent>((event, emit) async {
      emit(LoadDirectoryListState());
      directoryPaths.clear();
      await loaddirectory();
      emit(DirectoryListState(directoryPaths));
    });
  }
  Future<void> loaddirectory() async {
    songs = await audioQuery.querySongs();

    for (var song in songs) {
      if (directoryPaths
              .contains(song.data.substring(0, song.data.lastIndexOf("/"))) ==
          false) {
        directoryPaths.add(song.data.substring(0, song.data.lastIndexOf("/")));
      }
    }
    directoryPaths.sort();
  }
}

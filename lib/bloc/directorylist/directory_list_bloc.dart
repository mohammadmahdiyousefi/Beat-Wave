import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_event.dart';
import 'package:justaudioplayer/bloc/directorylist/directory_list_state.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryListBloc extends Bloc<IListEvent, IListState> {
  List<String> directoryPaths = [];
  // late List<Directory> directorylist;
  OnAudioQuery _audioQuery = OnAudioQuery();
  late List<SongModel> songs;
  DirectoryListBloc(super.initialState) {
    on<LoadListEvent>((event, emit) async {
      emit(LoadListState());

      // directorylist.clear();
      directoryPaths.clear();
      // var setexternal = await ExternalPath.getExternalStorageDirectories();

      // for (var storage in setexternal) {
      //   await getDirectories(storage);
      // }
      await loaddirectory();

      emit(ListState(directoryPaths));
    });
    on<UpdateistEvent>((event, emit) async {});
  }
  Future<void> loaddirectory() async {
    songs = await _audioQuery.querySongs();
    // for (var location in directoryPaths) {
    //   Directory directory = Directory(location);
    //   if (directory
    //           .listSync()
    //           .where((file) =>
    //               file.path.endsWith('.mp3') ||
    //               file.path.endsWith('.m4a') ||
    //               file.path.endsWith('.aac') ||
    //               file.path.endsWith('.ogg') ||
    //               file.path.endsWith('.wav'))
    //           .map((file) => File(file.path))
    //           .toList()
    //           .isNotEmpty &&
    //       directorylist.contains(directory) == false) {
    //     directorylist.add(directory);
    //   }
    // }
    for (var song in songs) {
      if (directoryPaths
              .contains(song.data.substring(0, song.data.lastIndexOf("/"))) ==
          false) {
        directoryPaths.add(song.data.substring(0, song.data.lastIndexOf("/")));
      }
    }
    directoryPaths.sort();
  }

  // Future<void> getDirectories(String path) async {
  //   Directory directory = Directory(path);
  //   if (directory.path.endsWith("/Android") == false) {
  //     if (directory.existsSync()) {
  //       directoryPaths.add(directory.path);
  //       List<FileSystemEntity> entities = directory.listSync();
  //       for (FileSystemEntity entity in entities) {
  //         if (entity is Directory) {
  //           await getDirectories(entity.path);
  //         }
  //       }
  //     }
  //   }
  // }
}

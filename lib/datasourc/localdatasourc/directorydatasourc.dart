import 'package:on_audio_query/on_audio_query.dart';

abstract class IDirectoryDatasourc {
  Future<List<String>> getdirectorydatasourc();
}

class DirectoryDataSourc extends IDirectoryDatasourc {
  List<String> directoryPaths = [];
  OnAudioQuery audioQuery = OnAudioQuery();
  late List<SongModel> songs = [];
  @override
  Future<List<String>> getdirectorydatasourc() async {
    try {
      await loaddirectory();
      return directoryPaths;
    } catch (ex) {
      throw ex;
    }
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

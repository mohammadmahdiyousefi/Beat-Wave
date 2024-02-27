import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IDirectoryDatasourc {
  Future<List<String>> getdirectorydatasourc();
}

class DirectoryDataSourc extends IDirectoryDatasourc {
  late List<String> directoryPaths = [];
  final OnAudioQuery audioQuery = locator.get<OnAudioQuery>();
  @override
  Future<List<String>> getdirectorydatasourc() async {
    try {
      directoryPaths = await audioQuery.queryAllPath();
      return directoryPaths;
    } catch (ex) {
      throw ex.toString();
    }
  }
}

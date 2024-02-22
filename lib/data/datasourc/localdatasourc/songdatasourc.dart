import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ISongDatasourc {
  Future<List<SongModel>> getAllSongDatasourc();
  Future<List<SongModel>> getSongDatasourc(int id, AudiosFromType type);
  Future<List<SongModel>> getFromFolderSongDatasourc(String path);
}

class SongDataSourc extends ISongDatasourc {
  final OnAudioQuery _allsongs = locator.get<OnAudioQuery>();
  late List<SongModel> allsongs;
  @override
  Future<List<SongModel>> getAllSongDatasourc() async {
    try {
      allsongs = await _allsongs.querySongs();
      return allsongs;
    } catch (ex) {
      throw ex.toString();
    }
  }

  @override
  Future<List<SongModel>> getFromFolderSongDatasourc(String path) async {
    try {
      allsongs = await _allsongs.querySongs();
      allsongs = allsongs
          .where((track) =>
              track.data.substring(0, track.data.lastIndexOf("/")) == path)
          .map((track) => SongModel(track.getMap))
          .toList();
      return allsongs;
    } catch (ex) {
      throw ex.toString();
    }
  }

  @override
  Future<List<SongModel>> getSongDatasourc(int id, AudiosFromType type) async {
    try {
      allsongs = await _allsongs.queryAudiosFrom(type, id);
      return allsongs;
    } catch (ex) {
      throw ex.toString();
    }
  }
}

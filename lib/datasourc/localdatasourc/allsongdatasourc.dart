import 'package:on_audio_query/on_audio_query.dart';

abstract class IAllsongDatasourc {
  Future<List<SongModel>> getallsongdatasourc();
}

class AllSongDataSourc extends IAllsongDatasourc {
  final OnAudioQuery _allsongs = OnAudioQuery();
  late List<SongModel> allsongs;
  @override
  Future<List<SongModel>> getallsongdatasourc() async {
    try {
      allsongs = await _allsongs.querySongs();
      return allsongs;
    } catch (ex) {
      throw ex;
    }
  }
}

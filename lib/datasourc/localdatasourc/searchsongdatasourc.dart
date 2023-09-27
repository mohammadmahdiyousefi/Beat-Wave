import 'package:on_audio_query/on_audio_query.dart';

abstract class ISearchsongDatasourc {
  Future<List<SongModel>> getsearchsongdatasourc(String titel);
}

class SearchSongDataSourc extends ISearchsongDatasourc {
  final OnAudioQuery _allsongs = OnAudioQuery();
  late List<SongModel> newlist;
  @override
  Future<List<SongModel>> getsearchsongdatasourc(String titel) async {
    try {
      newlist = await _allsongs.querySongs();
      newlist = newlist
          .where((element) =>
              element.displayName.toLowerCase().contains(titel.toLowerCase()))
          .toList();
      return newlist;
    } catch (ex) {
      throw ex;
    }
  }
}

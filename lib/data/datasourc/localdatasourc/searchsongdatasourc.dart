import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ISearchsongDatasourc {
  Future<List<SongModel>> getsearchsongdatasourc(String titel);
}

class SearchSongDataSourc extends ISearchsongDatasourc {
  final OnAudioQuery _allsongs = locator.get<OnAudioQuery>();
  late List<SongModel> newlist;
  @override
  Future<List<SongModel>> getsearchsongdatasourc(String titel) async {
    try {
      newlist = await _allsongs.querySongs();
      if (titel.isEmpty) {
        return newlist;
      } else {
        newlist = newlist
            .where((element) =>
                element.displayName.toLowerCase().contains(titel.toLowerCase()))
            .toList();
        return newlist;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}

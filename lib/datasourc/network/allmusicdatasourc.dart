import 'package:dio/dio.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAllMusicDatasourc {
  Future<List<Items>> getAllMusicdatasourc();
}

class AllMusicDataSourc extends IAllMusicDatasourc {
  final Dio _dio = locator.get();
  @override
  Future<List<Items>> getAllMusicdatasourc() async {
    try {
      var listmusic = await _dio.get("collections/Music/records");
      return listmusic.data['items']
          .map<Items>((jsonObject) => Items.fromJson(jsonObject))
          .toList();
    } catch (ex) {
      throw ex;
    }
  }
}

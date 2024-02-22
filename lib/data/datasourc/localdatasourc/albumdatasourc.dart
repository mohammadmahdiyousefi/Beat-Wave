import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAlbumDatasourc {
  Future<List<AlbumModel>> getAlbumDatasourc();
}

class AlbumDataSourc extends IAlbumDatasourc {
  final OnAudioQuery _album = locator.get<OnAudioQuery>();
  late List<AlbumModel> album;
  @override
  Future<List<AlbumModel>> getAlbumDatasourc() async {
    try {
      album = await _album.queryAlbums();
      return album;
    } catch (ex) {
      throw ex.toString();
    }
  }
}

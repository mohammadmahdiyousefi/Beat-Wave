import 'package:on_audio_query/on_audio_query.dart';

abstract class IAlbumDatasourc {
  Future<List<AlbumModel>> getalbumdatasourc();
}

class AlbumDataSourc extends IAlbumDatasourc {
  final OnAudioQuery _album = OnAudioQuery();
  late List<AlbumModel> album;
  @override
  Future<List<AlbumModel>> getalbumdatasourc() async {
    try {
      album = await _album.queryAlbums();
      return album;
    } catch (ex) {
      throw ex;
    }
  }
}

import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistDatasourc {
  Future<List<ArtistModel>> getartistdatasourc();
}

class ArtistDataSourc extends IArtistDatasourc {
  final OnAudioQuery _artist = OnAudioQuery();
  late List<ArtistModel> artist;
  @override
  Future<List<ArtistModel>> getartistdatasourc() async {
    try {
      artist = await _artist.queryArtists();
      return artist;
    } catch (ex) {
      throw ex;
    }
  }
}

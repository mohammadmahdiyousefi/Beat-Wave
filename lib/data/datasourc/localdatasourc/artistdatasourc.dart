import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistDatasourc {
  Future<List<ArtistModel>> getArtistDatasourc();
}

class ArtistDataSourc extends IArtistDatasourc {
  final OnAudioQuery _artist = locator.get<OnAudioQuery>();
  late List<ArtistModel> artist;
  @override
  Future<List<ArtistModel>> getArtistDatasourc() async {
    try {
      artist = await _artist.queryArtists();
      return artist;
    } catch (ex) {
      throw ex.toString();
    }
  }
}

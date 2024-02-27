import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlaylistDatasourc {
  Future<List<PlaylistModel>> getPlaylistdatasourc();
}

class PlaylistDataSourc extends IPlaylistDatasourc {
  final OnAudioQuery _playlist = locator.get<OnAudioQuery>();

  @override
  Future<List<PlaylistModel>> getPlaylistdatasourc() async {
    try {
      List<PlaylistModel> playlist = await _playlist.queryPlaylists();
      return playlist;
    } catch (ex) {
      throw ex.toString();
    }
  }
}

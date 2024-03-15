import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayListHandler {
  static final OnAudioQuery _audioQuery = locator.get<OnAudioQuery>();
  static Future<bool> createPlaylist(String playlistName) async {
    final bool isCreated = await _audioQuery.createPlaylist(playlistName);
    return isCreated;
  }

  static Future<bool> removePlaylist(int playlistId) async {
    bool isDeleted = false;
    await Permission.manageExternalStorage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        isDeleted = await _audioQuery.removePlaylist(playlistId);
      } else {
        isDeleted = false;
      }
    });
    return isDeleted;
  }

  static Future<bool> addToPlaylist(int playlistId, int audioId) async {
    final bool isAdded = await _audioQuery.addToPlaylist(playlistId, audioId);
    return isAdded;
  }

  static Future<bool> removeFromPlaylist(int playlistId, int audioId) async {
    bool isDeleted = false;
    await Permission.manageExternalStorage.request().then((value) async {
      if (value == PermissionStatus.granted) {
        isDeleted = await _audioQuery.removeFromPlaylist(playlistId, audioId);
      } else {
        isDeleted = false;
      }
    });
    return isDeleted;
  }

  static Future<bool> renamePlaylist(int playlistId, String newName) async {
    final bool isDeleted =
        await _audioQuery.renamePlaylist(playlistId, newName);
    return isDeleted;
  }
}

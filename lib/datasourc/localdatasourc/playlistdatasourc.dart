import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaudioplayer/model/playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlaylistDatasourc {
  Future<List<Playlist>> getplaylistdatasourc();
}

class PlaylistDataSourc extends IPlaylistDatasourc {
  late List<Playlist> playlist;
  @override
  Future<List<Playlist>> getplaylistdatasourc() async {
    try {
      var playlistbox = Hive.box<Playlist>("playlist");
      return playlistbox.values.toList();
    } catch (ex) {
      throw ex;
    }
  }
}

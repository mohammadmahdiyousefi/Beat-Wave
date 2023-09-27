import 'package:dartz/dartz.dart';

import 'package:justaudioplayer/datasourc/localdatasourc/playlistdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/model/playlist.dart';

abstract class IPlaylistRepository {
  Future<Either<String, List<Playlist>>> getplaylistrepository();
}

class PlaylistRepository extends IPlaylistRepository {
  @override
  Future<Either<String, List<Playlist>>> getplaylistrepository() async {
    final IPlaylistDatasourc datasourc = locator.get();
    try {
      var playlistlist = await datasourc.getplaylistdatasourc();
      return right(playlistlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

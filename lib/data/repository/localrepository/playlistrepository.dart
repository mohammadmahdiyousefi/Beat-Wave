import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/playlistdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlaylistRepository {
  Future<Either<String, List<PlaylistModel>>> getPlaylistrepository();
}

class PlaylistRepository extends IPlaylistRepository {
  final IPlaylistDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<PlaylistModel>>> getPlaylistrepository() async {
    try {
      final List<PlaylistModel> playlistlist =
          await datasourc.getPlaylistdatasourc();
      return right(playlistlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

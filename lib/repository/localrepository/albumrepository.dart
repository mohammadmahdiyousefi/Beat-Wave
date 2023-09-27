import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/albumdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAlbumRepository {
  Future<Either<String, List<AlbumModel>>> getalbumrepository();
}

class AlbumRepository extends IAlbumRepository {
  @override
  Future<Either<String, List<AlbumModel>>> getalbumrepository() async {
    final IAlbumDatasourc datasourc = locator.get();
    try {
      var albumlist = await datasourc.getalbumdatasourc();
      return right(albumlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

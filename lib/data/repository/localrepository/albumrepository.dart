import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/albumdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAlbumRepository {
  Future<Either<String, List<AlbumModel>>> getAlbumRepository();
}

class AlbumRepository extends IAlbumRepository {
  final IAlbumDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<AlbumModel>>> getAlbumRepository() async {
    try {
      final List<AlbumModel> albumlist = await datasourc.getAlbumDatasourc();
      return right(albumlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

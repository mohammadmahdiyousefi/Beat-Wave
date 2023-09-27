import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/allsongdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAllsongRepository {
  Future<Either<String, List<SongModel>>> getallsongrepository();
}

class AllSongRepository extends IAllsongRepository {
  @override
  Future<Either<String, List<SongModel>>> getallsongrepository() async {
    final IAllsongDatasourc datasourc = locator.get();
    try {
      var listsong = await datasourc.getallsongdatasourc();
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

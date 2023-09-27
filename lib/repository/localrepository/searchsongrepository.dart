import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/allsongdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/searchsongdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ISearchsongRepository {
  Future<Either<String, List<SongModel>>> getsearchsongrepository(String titel);
}

class searchSongRepository extends ISearchsongRepository {
  @override
  Future<Either<String, List<SongModel>>> getsearchsongrepository(
      String titel) async {
    final ISearchsongDatasourc datasourc = locator.get();
    try {
      var listsong = await datasourc.getsearchsongdatasourc(titel);
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

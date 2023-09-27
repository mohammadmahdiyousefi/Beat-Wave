import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/datasourc/network/allmusicdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IAllMusicRepository {
  Future<Either<String, List<Items>>> getallmusicrepository();
}

class AllMusicRepository extends IAllMusicRepository {
  @override
  Future<Either<String, List<Items>>> getallmusicrepository() async {
    final IAllMusicDatasourc datasourc = locator.get();
    try {
      var listsong = await datasourc.getAllMusicdatasourc();
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

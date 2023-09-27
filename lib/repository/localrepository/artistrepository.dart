import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/allsongdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/artistdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistRepository {
  Future<Either<String, List<ArtistModel>>> getartistrepository();
}

class ArtistRepository extends IArtistRepository {
  @override
  Future<Either<String, List<ArtistModel>>> getartistrepository() async {
    final IArtistDatasourc datasourc = locator.get();
    try {
      var artistlist = await datasourc.getartistdatasourc();
      return right(artistlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/artistdatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IArtistRepository {
  Future<Either<String, List<ArtistModel>>> getArtistRepository();
}

class ArtistRepository extends IArtistRepository {
  final IArtistDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<ArtistModel>>> getArtistRepository() async {
    try {
      final List<ArtistModel> artistlist = await datasourc.getArtistDatasourc();
      return right(artistlist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

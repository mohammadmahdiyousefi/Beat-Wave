import 'package:dartz/dartz.dart';
import 'package:beat_wave/data/datasourc/localdatasourc/searchsongdatasourc.dart';
import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ISearchsongRepository {
  Future<Either<String, List<SongModel>>> getsearchsongrepository(String titel);
}

class SearchSongRepository extends ISearchsongRepository {
  final ISearchsongDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<SongModel>>> getsearchsongrepository(
      String titel) async {
    try {
      final List<SongModel> listsong =
          await datasourc.getsearchsongdatasourc(titel);
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:beat_wave/data/datasourc/localdatasourc/songdatasourc.dart';
import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class ISongRepository {
  Future<Either<String, List<SongModel>>> getAllSongRepository();
  Future<Either<String, List<SongModel>>> getSongRepository(
      int id, AudiosFromType type);
  Future<Either<String, List<SongModel>>> getFromFoldersongRepository(
      String path);
}

class SongRepository extends ISongRepository {
  final ISongDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<SongModel>>> getAllSongRepository() async {
    try {
      final List<SongModel> listsong = await datasourc.getAllSongDatasourc();
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<SongModel>>> getFromFoldersongRepository(
      String path) async {
    try {
      final List<SongModel> listsong =
          await datasourc.getFromFolderSongDatasourc(path);
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }

  @override
  Future<Either<String, List<SongModel>>> getSongRepository(
      int id, AudiosFromType type) async {
    try {
      var listsong = await datasourc.getSongDatasourc(id, type);
      return right(listsong);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

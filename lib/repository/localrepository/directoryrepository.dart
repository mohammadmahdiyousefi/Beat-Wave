import 'package:dartz/dartz.dart';

import 'package:justaudioplayer/datasourc/localdatasourc/directorydatasourc.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IDirectoryRepository {
  Future<Either<String, List<String>>> getdirectoryrepository();
}

class DirectoryRepository extends IDirectoryRepository {
  @override
  Future<Either<String, List<String>>> getdirectoryrepository() async {
    final IDirectoryDatasourc datasourc = locator.get();
    try {
      var directorylist = await datasourc.getdirectorydatasourc();
      return right(directorylist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

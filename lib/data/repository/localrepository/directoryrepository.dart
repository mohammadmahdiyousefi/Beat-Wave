import 'package:dartz/dartz.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/directorydatasourc.dart';
import 'package:justaudioplayer/di/di.dart';

abstract class IDirectoryRepository {
  Future<Either<String, List<String>>> getdirectoryrepository();
}

class DirectoryRepository extends IDirectoryRepository {
  final IDirectoryDatasourc datasourc = locator.get();
  @override
  Future<Either<String, List<String>>> getdirectoryrepository() async {
    try {
      final List<String> directorylist =
          await datasourc.getdirectorydatasourc();
      return right(directorylist);
    } catch (ex) {
      return left(ex.toString());
    }
  }
}

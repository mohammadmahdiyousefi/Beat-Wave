import 'package:hive/hive.dart';
part 'playlist.g.dart';

@HiveType(typeId: 0)
class Playlist extends HiveObject {
  Playlist({
    required this.name,
    this.imageid,
    required this.songs,
  });
  @HiveField(0)
  String name;
  @HiveField(1)
  int? imageid;
  @HiveField(2)
  List<String> songs = [];
}

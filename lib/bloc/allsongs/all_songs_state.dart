import 'package:on_audio_query/on_audio_query.dart';

abstract class IAllSnogsState {}

class InitAllSongs extends IAllSnogsState {}

class AllSongsState extends IAllSnogsState {
  List<SongModel> allsongs;
  AllSongsState(this.allsongs);
}

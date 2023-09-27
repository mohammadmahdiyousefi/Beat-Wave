import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlayerEvent {}

class InitPlayerEnent extends IPlayerEvent {
  int index;
  List<SongModel> songlist;
  String path;
  InitPlayerEnent(this.songlist, this.index, this.path);
}

class InitNetworkPlayerEnent extends IPlayerEvent {
  String url;
  String path;
  InitNetworkPlayerEnent(this.url, this.path);
}

class InitHivePlayerEnent extends IPlayerEvent {
  String path;
  InitHivePlayerEnent(this.path);
}

class StartPlayerEnent extends IPlayerEvent {}

class PausePlayerEnent extends IPlayerEvent {}

class SeekPlayerEnent extends IPlayerEvent {
  Duration seek = Duration.zero;

  SeekPlayerEnent(this.seek);
}

class NextPlayerEnent extends IPlayerEvent {}

class PreviousPlayerEnent extends IPlayerEvent {}

class UpdatePlayerEnent extends IPlayerEvent {}

class LoopPlayerEnent extends IPlayerEvent {}

class ShufflePlayerEnent extends IPlayerEvent {}

class SpeedPlayerEnent extends IPlayerEvent {
  double speed;
  SpeedPlayerEnent(this.speed);
}

class VolumPlayerEnent extends IPlayerEvent {
  double volum;
  VolumPlayerEnent(this.volum);
}

class DisposePlayerEnent extends IPlayerEvent {}

import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlayerState {}

class InitAudioState extends IPlayerState {
  InitAudioState();
}

class PlayAudioState extends IPlayerState {
  int index;
  String path;
  SongModel song;
  PlayAudioState(this.index, this.song, this.path);
}

class LoadAudioState extends IPlayerState {
  LoadAudioState();
}

class ErrorAudioState extends IPlayerState {
  ErrorAudioState();
}

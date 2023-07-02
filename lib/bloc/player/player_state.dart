import 'package:on_audio_query/on_audio_query.dart';

abstract class IPlayerState {}

class PlayAudioState extends IPlayerState {
  int index;
  PlayAudioState(this.index);
}

class LoadAudioState extends IPlayerState {
  LoadAudioState();
}

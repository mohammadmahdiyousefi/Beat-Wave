import 'package:flutter/material.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IMusicNetworkState {}

class LoadMusicNetworkState extends IMusicNetworkState {}

class MusicNetworkState extends IMusicNetworkState {
  List<SongModel> musics;
  MusicNetworkState(this.musics);
}

class ErrorMusicNetworkState extends IMusicNetworkState {}

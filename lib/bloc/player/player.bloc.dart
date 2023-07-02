import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:justaudioplayer/bloc/player/player_event.dart';
import 'package:justaudioplayer/bloc/player/player_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerBloc extends Bloc<IPlayerEvent, IPlayerState> {
  final player = AudioPlayer();
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> songlist = [];
  List<AudioSource> source = [];
  String path = '';
  final box = Hive.box('songlist');
  var playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: []);
  PlayerBloc(super.initialState) {
    on<InitPlayerEnent>((event, emit) async {
      emit(LoadAudioState());
      if (event.songlist.length == box.length && event.path == path) {
        setAudioSource(event.index, event.songlist);
      } else {
        path = event.path;
        await saveSongList(event.songlist);
        setAudioSource(event.index, event.songlist);
      }
      emit(PlayAudioState(player.currentIndex!));
    });
    on<StartPlayerEnent>((event, emit) {
      player.play();
    });
    on<PausePlayerEnent>((event, emit) async {
      await player.pause();
    });
    on<SeekPlayerEnent>((event, emit) async {
      if (event.seek > player.duration!) {
        await player.seekToNext();
        emit(PlayAudioState(player.currentIndex!));
      } else if (event.seek < Duration.zero) {
        await player.seekToPrevious();
        emit(PlayAudioState(player.currentIndex!));
      } else {
        await player.seek(event.seek);
      }
    });
    on<UpdatePlayerEnent>((event, emit) async {
      emit(PlayAudioState(player.currentIndex ?? 0));
    });
    on<NextPlayerEnent>((event, emit) async {
      await player.seekToNext();
      emit(PlayAudioState(player.currentIndex!));
    });
    on<PreviousPlayerEnent>((event, emit) async {
      if (player.position < const Duration(seconds: 5)) {
        await player.seekToPrevious();
        emit(PlayAudioState(player.currentIndex!));
      } else {
        await player.seek(Duration.zero);
      }
    });
    on<ShufflePlayerEnent>((event, emit) async {
      await player.setShuffleModeEnabled(!player.shuffleModeEnabled);
    });
    on<LoopPlayerEnent>((event, emit) async {
      if (player.loopMode == LoopMode.off) {
        await player.setLoopMode(LoopMode.one);
      } else if (player.loopMode == LoopMode.one) {
        await player.setLoopMode(LoopMode.all);
      } else {
        await player.setLoopMode(LoopMode.off);
      }
    });
    on<SpeedPlayerEnent>((event, emit) async {
      await player.setSpeed(event.speed);
    });
    on<DisposePlayerEnent>((event, emit) async {
      await player.dispose();
    });
    on<VolumPlayerEnent>((event, emit) async {
      await player.setVolume(event.volum);
    });
    on<InitHivePlayerEnent>((event, emit) async {
      emit(LoadAudioState());
      await loadSongList();
      await setAudioSource(0, songlist);
      emit(PlayAudioState(player.currentIndex!));
    });
  }

  Future<void> setAudioSource(int index, List<SongModel> songlist) async {
    source.clear();

    for (var file in songlist) {
      source.add(AudioSource.file(file.data,
          tag: MediaItem(
              id: file.id.toString(),
              title: file.title,
              artist: file.artist,
              album: file.album,
              genre: file.genre,
              displayTitle: file.displayNameWOExt,
              duration: Duration(seconds: file.duration!),
              displayDescription: file.displayName,
              artUri: Uri.file(
                  "/storage/emulated/0/Music/.thumbnails/${file.id.toString()}.jpg"))));

      playlist = ConcatenatingAudioSource(
          useLazyPreparation: true,
          shuffleOrder: DefaultShuffleOrder(),
          children: source);
    }

    await player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }

  Future<void> saveSongList(List<SongModel> songList) async {
    await box.clear();
    for (var item in songList) {
      String json = jsonEncode(item.getMap);
      await box.add(json);
    }
  }

  Future<List<SongModel>> loadSongList() async {
    songlist.clear();
    for (var song in box.values.toList()) {
      dynamic decodedJson = jsonDecode(song);
      SongModel audio = SongModel(decodedJson);
      songlist.add(audio);
    }
    return [];
  }
}

import 'dart:convert';

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
  final playermode = Hive.box('playmode');
  final box = Hive.box('songlist');
  final networkbox = Hive.box('NetworkSonglist');
  var playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: []);
  PlayerBloc() : super(InitAudioState()) {
    on<InitPlayerEnent>((event, emit) async {
      emit(LoadAudioState());
      try {
        if (event.path == "search") {
          songlist.clear();
          setSearchAudioSource(
            event.songlist[event.index],
          );
          songlist.add(event.songlist[event.index]);
          emit(PlayAudioState(0, songlist[0], path));
          await saveSongList(songlist);
        } else if (event.path == "Network") {
          if (event.songlist.length == box.length && event.path == path) {
            setNetworkAudioSource(event.index, event.songlist, event.path);
            songlist = event.songlist;
            emit(
                PlayAudioState(event.index, songlist[event.index], event.path));
          } else {
            setNetworkAudioSource(event.index, event.songlist, event.path);
            songlist = event.songlist;
            emit(
                PlayAudioState(event.index, songlist[event.index], event.path));
            await saveSongList(event.songlist);
          }
        } else {
          if (event.songlist.length == box.length && event.path == path) {
            setAudioSource(
              event.index,
              event.songlist,
            );
            songlist = event.songlist;
            emit(
                PlayAudioState(event.index, songlist[event.index], event.path));
          } else {
            setAudioSource(
              event.index,
              event.songlist,
            );
            songlist = event.songlist;
            emit(
                PlayAudioState(event.index, songlist[event.index], event.path));
            await saveSongList(event.songlist);
          }
        }
        path = event.path;
        playermode.put("mode", event.path);
      } catch (ex) {
        emit(ErrorAudioState());
      }
    });
    on<InitNetworkPlayerEnent>((event, emit) async {
      emit(LoadAudioState());
      Map<dynamic, dynamic> info = {
        "_id": 0,
        "_data": event.url,
        "_uri": event.url,
        "_display_name": event.url,
        "_display_name_wo_ext": event.url,
        "_size": 0,
        "album": "Null",
        "album_id": 0,
        "artist": "<unknown>",
        "artist_id": 0,
        "genre": "Null",
        "genre_id": 0,
        "bookmark": 0,
        "composer": "Null",
        "date_added": 0,
        "date_modified": 0,
        "duration": 0,
        "title": event.url,
        "track": 0,
        "file_extension": event.path,
        "is_alarm": false,
        "is_audiobook": false,
        "is_music": true,
        "is_notification": false,
        "is_podcast": false,
        "is_ringtone": false,
      };
      if (networkbox.keys.toList().contains(event.url) == false &&
          event.url != "") {
        await networkbox.put(event.url, info);
        await loadnetworkSongList();
        await setAudioSource(
          networkbox.values.toList().lastIndexOf(info),
          songlist,
        );
        await saveSongList(songlist);
        player.play();
      } else {}

      emit(PlayAudioState(
          player.currentIndex!, songlist[player.currentIndex!], path));
    });
    on<StartPlayerEnent>((event, emit) async {
      await player.play();
    });
    on<PausePlayerEnent>((event, emit) async {
      await player.pause();
    });
    on<SeekPlayerEnent>((event, emit) async {
      if (event.seek > player.duration!) {
        await player.seekToNext();
        emit(PlayAudioState(
            player.currentIndex!, songlist[player.currentIndex!], path));
      } else if (event.seek < Duration.zero) {
        await player.seekToPrevious();
        emit(PlayAudioState(
            player.currentIndex!, songlist[player.currentIndex!], path));
      } else {
        await player.seek(event.seek);
      }
    });
    on<UpdatePlayerEnent>((event, emit) async {
      emit(PlayAudioState(
          player.currentIndex ?? 0, songlist[player.currentIndex!], path));
    });
    on<NextPlayerEnent>((event, emit) async {
      await player.seekToNext();

      emit(PlayAudioState(
          player.currentIndex!, songlist[player.currentIndex!], path));
    });
    on<PreviousPlayerEnent>((event, emit) async {
      if (player.position < const Duration(seconds: 5)) {
        await player.seekToPrevious();

        emit(PlayAudioState(
            player.currentIndex!, songlist[player.currentIndex!], path));
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
      if (box.values.toList().isEmpty) {
        emit(InitAudioState());
      } else {
        emit(LoadAudioState());
        await loadSongList();
        if (playermode.get("mode") == "Network") {
          await setNetworkAudioSource(0, songlist, "Network");
        } else {
          await setAudioSource(
            0,
            songlist,
          );
        }
        path = event.path;
        emit(PlayAudioState(
            player.currentIndex!, songlist[player.currentIndex!], path));
      }
    });
  }
  Future<void> setNetworkAudioSource(
      int index, List<SongModel> songlist, String path) async {
    source.clear();
    for (var file in songlist) {
      source.add(AudioSource.uri(Uri.parse(file.uri!),
          tag: MediaItem(
              id: file.uri!,
              title: file.title,
              artist: file.artist,
              album: file.album,
              genre: file.genre,
              displayTitle: file.displayNameWOExt,
              duration: Duration(seconds: file.duration!),
              displayDescription: file.displayName,
              playable: true,
              artUri: Uri.parse(file.data))));
    }
    playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: source);

    player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }

  Future<void> setAudioSource(
    int index,
    List<SongModel> songlist,
  ) async {
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
              playable: true,
              artUri: Uri.file(
                  "/storage/emulated/0/Music/.thumbnails/${file.id}.jpg"))));
    }
    playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: source);

    player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);
  }

  Future<void> setSearchAudioSource(
    SongModel songlist,
  ) async {
    source.clear();
    source.add(
      AudioSource.file(
        songlist.data,
        tag: MediaItem(
          id: songlist.id.toString(),
          title: songlist.title,
          artist: songlist.artist,
          album: songlist.album,
          genre: songlist.genre,
          displayTitle: songlist.displayNameWOExt,
          duration: Duration(seconds: songlist.duration!),
          displayDescription: songlist.displayName,
          playable: true,
          artUri: Uri.file(
              "/storage/emulated/0/Music/.thumbnails/${songlist.id}.jpg"),
        ),
      ),
    );
    playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: source);

    player.setAudioSource(playlist,
        initialIndex: 0, initialPosition: Duration.zero);
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

  Future<List<SongModel>> loadnetworkSongList() async {
    songlist.clear();
    for (var song in networkbox.values.toList()) {
      SongModel audio = SongModel(song);
      songlist.add(audio);
    }

    return [];
  }
}

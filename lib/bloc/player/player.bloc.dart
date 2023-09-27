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
  final box = Hive.box('songlist');
  final networkbox = Hive.box('NetworkSonglist');
  var playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: []);
  PlayerBloc(super.initialState) {
    on<InitPlayerEnent>((event, emit) async {
      emit(LoadAudioState());
      if (event.path == "search") {
        List<SongModel> songs = [];
        songs.add(event.songlist[event.index]);
        path = event.path;
        setAudioSource(0, songs);
        await saveSongList(songs);
      } else {
        if (event.songlist.length == box.length && event.path == path) {
          setAudioSource(event.index, event.songlist);
        } else {
          path = event.path;
          setAudioSource(event.index, event.songlist);
          await saveSongList(event.songlist);
        }
      }

      emit(PlayAudioState(player.currentIndex!));
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
        "file_extension": "Network",
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
            networkbox.values.toList().lastIndexOf(info), songlist);
        await saveSongList(songlist);
        player.play();
      } else {}

      emit(PlayAudioState(player.currentIndex!));
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
      if (box.values.toList().isEmpty) {
        emit(LoadAudioState());
      } else {
        emit(LoadAudioState());
        await loadSongList();
        await setAudioSource(0, songlist);
        emit(PlayAudioState(player.currentIndex!));
      }
    });
  }

  Future<void> setAudioSource(int index, List<SongModel> songlist) async {
    source.clear();

    for (var file in songlist) {
      source.add(file.fileExtension == "Network"
          ? AudioSource.uri(Uri.parse(file.uri!),
              tag: MediaItem(id: file.uri!, title: file.title))
          : AudioSource.file(file.data,
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
                      "/storage/emulated/0/Music/.thumbnails/${file.id}.jpg"))));
    }
    playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: source);

    player.setAudioSource(playlist,
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

  Future<List<SongModel>> loadnetworkSongList() async {
    songlist.clear();
    for (var song in networkbox.values.toList()) {
      SongModel audio = SongModel(song);
      songlist.add(audio);
    }

    return [];
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_networc_event.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_network_state.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:justaudioplayer/repository/network/allmusicrepository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicNetworkBloc extends Bloc<IMusicNetworkEvent, IMusicNetworkState> {
  final IAllMusicRepository _repository = locator.get();
  List<SongModel> songlist = [];
  MusicNetworkBloc() : super(LoadMusicNetworkState()) {
    on<MusicNetworkEvent>((event, emit) async {
      emit(LoadMusicNetworkState());
      var respons = await _repository.getallmusicrepository();
      respons.fold((l) {
        emit(ErrorMusicNetworkState());
      }, (songs) {
        creatsongmodel(songs);
        emit(MusicNetworkState(songlist));
      });
    });
  }
  Future<List<SongModel>> creatsongmodel(List<Items> item) async {
    songlist.clear();
    for (var song in item) {
      Map<dynamic, dynamic> info = {
        "_id": 0,
        "_data": song.artWork,
        "_uri": song.audio,
        "_display_name": song.name,
        "_display_name_wo_ext": song.name,
        "_size": song.size!.toInt(),
        "album": song.albumName,
        "album_id": 0,
        "artist": song.artistName,
        "artist_id": 0,
        "genre": "Null",
        "genre_id": 0,
        "bookmark": 0,
        "composer": "Null",
        "date_added": 0,
        "date_modified": 0,
        "duration": Duration(seconds: song.time!).inMilliseconds,
        "title": song.titel,
        "track": 0,
        "file_extension": song.format,
        "is_alarm": false,
        "is_audiobook": false,
        "is_music": true,
        "is_notification": false,
        "is_podcast": false,
        "is_ringtone": false,
      };
      SongModel audio = SongModel(info);
      songlist.add(audio);
    }

    return [];
  }
}

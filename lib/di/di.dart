import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/albumdatasourc.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/songdatasourc.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/artistdatasourc.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/directorydatasourc.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/playlistdatasourc.dart';
import 'package:justaudioplayer/data/datasourc/localdatasourc/searchsongdatasourc.dart';
import 'package:justaudioplayer/data/repository/localrepository/albumrepository.dart';
import 'package:justaudioplayer/data/repository/localrepository/artistrepository.dart';
import 'package:justaudioplayer/data/repository/localrepository/directoryrepository.dart';
import 'package:justaudioplayer/data/repository/localrepository/playlistrepository.dart';
import 'package:justaudioplayer/data/repository/localrepository/searchsongrepository.dart';
import 'package:justaudioplayer/data/repository/localrepository/songrepository.dart';
import 'package:on_audio_query/on_audio_query.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //local datasourc
  locator.registerFactory<ISongDatasourc>(() => SongDataSourc());
  locator.registerFactory<IArtistDatasourc>(() => ArtistDataSourc());
  locator.registerFactory<IAlbumDatasourc>(() => AlbumDataSourc());
  locator.registerFactory<IPlaylistDatasourc>(() => PlaylistDataSourc());
  locator.registerFactory<IDirectoryDatasourc>(() => DirectoryDataSourc());
  locator.registerFactory<ISearchsongDatasourc>(() => SearchSongDataSourc());
  //repository
  locator.registerFactory<ISongRepository>(() => SongRepository());
  locator.registerFactory<IArtistRepository>(() => ArtistRepository());
  locator.registerFactory<IAlbumRepository>(() => AlbumRepository());
  locator.registerFactory<IPlaylistRepository>(() => PlaylistRepository());
  locator.registerFactory<IDirectoryRepository>(() => DirectoryRepository());
  locator.registerFactory<ISearchsongRepository>(() => SearchSongRepository());

  //onAudio
  locator.registerSingleton(OnAudioQuery());
  //just Audio
  locator.registerSingleton(AudioPlayer());
}

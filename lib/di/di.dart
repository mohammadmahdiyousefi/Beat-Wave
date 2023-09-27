import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/albumdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/allsongdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/artistdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/directorydatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/playlistdatasourc.dart';
import 'package:justaudioplayer/datasourc/localdatasourc/searchsongdatasourc.dart';
import 'package:justaudioplayer/datasourc/network/allmusicdatasourc.dart';
import 'package:justaudioplayer/repository/localrepository/albumrepository.dart';
import 'package:justaudioplayer/repository/localrepository/allsongrepository.dart';
import 'package:justaudioplayer/repository/localrepository/artistrepository.dart';
import 'package:justaudioplayer/repository/localrepository/directoryrepository.dart';
import 'package:justaudioplayer/repository/localrepository/playlistrepository.dart';
import 'package:justaudioplayer/repository/localrepository/searchsongrepository.dart';
import 'package:justaudioplayer/repository/network/allmusicrepository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  locator.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: 'https://pocketbase-32rnby.chbk.run/api/',
  )));
  //network datasorc
  locator.registerFactory<IAllMusicDatasourc>(() => AllMusicDataSourc());

  //local datasourc
  locator.registerFactory<IAllsongDatasourc>(() => AllSongDataSourc());
  locator.registerFactory<IArtistDatasourc>(() => ArtistDataSourc());
  locator.registerFactory<IAlbumDatasourc>(() => AlbumDataSourc());
  locator.registerFactory<IPlaylistDatasourc>(() => PlaylistDataSourc());
  locator.registerFactory<IDirectoryDatasourc>(() => DirectoryDataSourc());
  locator.registerFactory<ISearchsongDatasourc>(() => SearchSongDataSourc());
  //repository
  locator.registerFactory<IAllsongRepository>(() => AllSongRepository());
  locator.registerFactory<IArtistRepository>(() => ArtistRepository());
  locator.registerFactory<IAlbumRepository>(() => AlbumRepository());
  locator.registerFactory<IPlaylistRepository>(() => PlaylistRepository());
  locator.registerFactory<IDirectoryRepository>(() => DirectoryRepository());
  locator.registerFactory<ISearchsongRepository>(() => searchSongRepository());
  //network repository

  locator.registerFactory<IAllMusicRepository>(() => AllMusicRepository());
}

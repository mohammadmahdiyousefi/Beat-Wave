import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class IMainScreenEvent {}

class MainScreenEventEvent extends IMainScreenEvent {}

class AllSongScreenEvent extends IMainScreenEvent {}

class AlbumScreenEvent extends IMainScreenEvent {}

class ArtistScreenEvent extends IMainScreenEvent {}

class PlaylistScreenEvent extends IMainScreenEvent {}

class FavoritScreenEvent extends IMainScreenEvent {}

class DirectoryScreenEvent extends IMainScreenEvent {}

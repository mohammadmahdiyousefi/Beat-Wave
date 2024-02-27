import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerAudio {
  static Future<void> setAudioSource(
      final List<SongModel> newSongList, final int index,
      {final bool isShuffle = false}) async {
    final AudioPlayer player = locator.get<AudioPlayer>();
    List<AudioSource> source = [];
    ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: []);

    source.clear();

    for (var file in newSongList) {
      source.add(
        AudioSource.file(
          file.data,
          tag: MediaItem(
            id: file.id.toString(),
            title: file.displayNameWOExt,
            artist: file.artist,
            album: file.album,
            genre: file.genre,
            displayTitle: file.title,
            duration: Duration(seconds: file.duration!),
            displayDescription: file.displayName,
            playable: true,
            artUri: Uri.file(
                "/storage/emulated/0/Music/.thumbnails/${file.id}.jpg"),
            extras: {
              "SongModel": file.getMap
              // "_id": file.id,
              // "_data": file.data,
              // "_uri": file.uri,
              // "_display_name": file.displayName,
              // "_display_name_wo_ext": file.displayNameWOExt,
              // "_size": file.size,
              // "album": file.album,
              // "album_id": file.albumId,
              // "artist": file.artist,
              // "artist_id": file.albumId,
              // "genre": file.genre,
              // "bookmark": file.bookmark,
              // "composer": file.composer,
              // "date_added": file.dateAdded,
              // "date_modified": file.dateModified,
              // "duration": file.duration,
              // "title": file.title,
              // "track": file.track,
              // "file_extension": file.fileExtension,
              // "is_alarm": file.isAlarm,
              // "is_audiobook": file.isAudioBook,
              // "is_music": file.isMusic,
              // "is_notification": file.isNotification,
              // "is_podcast": file.isPodcast,
              // "is_ringtone": file.isRingtone,
            },
          ),
        ),
      );
    }
    playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: source);

    await player.setAudioSource(playlist,
        initialIndex: index, initialPosition: Duration.zero);

    player.play();
    player.setShuffleModeEnabled(isShuffle);
  }
}

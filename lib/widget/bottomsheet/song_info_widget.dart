import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<Widget?> songInfoBottomSheet(
  final BuildContext context,
  final SongModel song,
) {
  Map<String, dynamic> items = {
    "Id": song.id,
    "Title": song.title,
    "Data": song.data,
    "Display Name": song.displayNameWOExt,
    "Album": song.album,
    "Album id": song.albumId,
    "Artist": song.artist,
    "Artist id": song.artistId,
    "Gener": song.genre,
    "Track": song.track,
    "Size": formatBytes(song.size, 2),
    "Duration": timech(Duration(milliseconds: song.duration ?? 0)),
    "Data added":
        song.dateAdded != null ? dateConvort(song.dateAdded ?? 0) : null,
    "Data modified":
        song.dateModified != null ? dateConvort(song.dateModified ?? 0) : null,
    "File extention": song.fileExtension,
    "is Ringtone": song.isRingtone,
    "is Alarm": song.isAlarm,
    "is Notification": song.isNotification,
  };

  return showModalBottomSheet(
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    elevation: Theme.of(context).bottomSheetTheme.elevation,
    shape: Theme.of(context).bottomSheetTheme.shape,
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              shape: Theme.of(context).bottomSheetTheme.shape,
              elevation: Theme.of(context).bottomSheetTheme.elevation,
              backgroundColor:
                  Theme.of(context).bottomSheetTheme.backgroundColor,
              automaticallyImplyLeading: false,
              pinned: true,
              centerTitle: true,
              titleSpacing: 16,
              toolbarHeight: 45,
              scrolledUnderElevation: 0,
              title: Text(
                song.title,
                style: Theme.of(context).listTileTheme.titleTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 3),
                child: Divider(
                  thickness: 1,
                  height: 3,
                  indent: 16,
                  endIndent: 16,
                ),
              ),
            ),
            SliverList.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${items.keys.toList()[index]}  : ",
                        style:
                            Theme.of(context).listTileTheme.subtitleTextStyle),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        items.values.toList()[index].toString(),
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).listTileTheme.titleTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

String dateConvort(int epochTimestamp) {
  return DateFormat('MMM dd, yyyy (hh:mm)')
      .format(DateTime.fromMillisecondsSinceEpoch(epochTimestamp * 1000));
}

String timech(Duration duration) {
  String twoDigitMinutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  String twoDigitSeconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  if (duration.inHours != 0) {
    String time = '${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds';
    return time;
  } else {
    String time = '$twoDigitMinutes:$twoDigitSeconds';
    return time;
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes == 0) return "0 B";
  const k = 1024;
  final dm = decimals < 0 ? 0 : decimals;
  final sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  final i = (log(bytes) / log(k)).floor();
  return '${(bytes / pow(k, i)).toStringAsFixed(dm)} ${sizes[i]}';
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future songInfo(BuildContext context, SongModel song) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text(
                      "Song Info",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text("File", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.displayName,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Location",
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.data == "Null"
                        ? "Null"
                        : song.data.substring(0, song.data.lastIndexOf("/")),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Size", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    formatBytes(song.size, 2),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Date", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.dateAdded.toString(),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Titel", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.title,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Format", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.fileExtension,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Length", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    timech(Duration(milliseconds: song.duration!)),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Album", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.album!,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Artist", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.artist!.trim(),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("id", style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.id.toString(),
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
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

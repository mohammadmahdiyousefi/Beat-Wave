import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            color: const Color(0xff121212),
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
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "File",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.displayName,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Location",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.data.substring(0, song.data.lastIndexOf("/")),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Size",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    formatBytes(song.size, 2),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Date",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.dateAdded.toString(),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Titel",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.title,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Format",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.fileExtension,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Length",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    timech(Duration(milliseconds: song.duration!)),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Album",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.album!,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Artist",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.artist!.trim(),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "id",
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    song.id.toString(),
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 13,
                    ),
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

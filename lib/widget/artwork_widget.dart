import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class ArtworkSong extends StatelessWidget {
  ArtworkSong(
      {super.key,
      required this.id,
      this.size = 200,
      this.quality = 100,
      required this.height,
      required this.width,
      this.type = ArtworkType.AUDIO,
      this.nullartwork = "assets/images/cover.jpg",
      this.radius = 5,
      this.artworkQuality = FilterQuality.low});
  int id;
  double height;
  double width;
  int size;
  int quality;
  ArtworkType type;
  String nullartwork;
  double radius;
  FilterQuality artworkQuality;
  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      quality: quality,
      size: size,
      format: ArtworkFormat.JPEG,
      type: type,
      keepOldArtwork: true,
      artworkBorder: BorderRadius.circular(radius),
      artworkQuality: FilterQuality.medium,
      artworkFit: BoxFit.fill,
      artworkWidth: width,
      artworkHeight: height,
      nullArtworkWidget: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              image: AssetImage(nullartwork),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover),
          color: const Color.fromARGB(255, 61, 60, 60),
        ),
        // child: Image.asset("assets/images/cover.jpg")
      ),
    );
  }
}

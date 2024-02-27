import 'package:flutter/material.dart';
import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  SongTile({
    super.key,
    required this.song,
    required this.onTap,
    required this.moreOnTap,
  });
  final SongModel song;
  final Function()? onTap;
  final Function()? moreOnTap;
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        onTap: onTap,
        shape: Theme.of(context).listTileTheme.shape,
        contentPadding: const EdgeInsets.symmetric(horizontal: 7),
        title: Text(song.title),
        titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
        subtitle: Text(song.artist ?? "<unkown>"),
        subtitleTextStyle: Theme.of(context).listTileTheme.subtitleTextStyle,
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: const DecorationImage(
                  image: AssetImage("assets/images/cover.jpg"))),
          child: QueryArtworkWidget(
            id: song.id,
            quality: 50,
            size: 200,
            controller: onAudioQuery,
            format: ArtworkFormat.JPEG,
            type: ArtworkType.AUDIO,
            keepOldArtwork: false,
            artworkBorder: BorderRadius.circular(6),
            artworkQuality: FilterQuality.low,
            artworkFit: BoxFit.fill,
            artworkHeight: 50,
            artworkWidth: 50,
            nullArtworkWidget: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/cover.jpg",
                    ),
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover),
                color: const Color.fromARGB(255, 61, 60, 60),
              ),
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: moreOnTap,
          icon: const Icon(
            Icons.more_horiz,
            size: 30,
          ),
        ),
      ),
    );
  }
}

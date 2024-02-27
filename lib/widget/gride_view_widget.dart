import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class GrideViewWidget extends StatelessWidget {
  GrideViewWidget(
      {super.key,
      this.name = "",
      this.numberofsong = 0,
      this.id = 0,
      this.type = ArtworkType.ALBUM,
      this.nullartwork = "assets/images/album.png"});
  final String name;
  final int numberofsong;
  final int id;
  final ArtworkType type;
  final String nullartwork;
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff000000).withOpacity(0),
                      const Color(0xff000000).withOpacity(0.75),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage(
                      nullartwork,
                    ))),
                child: QueryArtworkWidget(
                  id: id,
                  quality: 60,
                  size: 600,
                  format: ArtworkFormat.JPEG,
                  controller: onAudioQuery,
                  type: type,
                  keepOldArtwork: false,
                  artworkBorder: BorderRadius.circular(25),
                  artworkQuality: FilterQuality.low,
                  artworkFit: BoxFit.fill,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage(
                            nullartwork,
                          ),
                          filterQuality: FilterQuality.low,
                          fit: BoxFit.cover),
                      color: const Color.fromARGB(255, 61, 60, 60),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  width: 36,
                  height: 36,
                  padding: const EdgeInsets.all(5),
                  decoration: const ShapeDecoration(
                    color: Color(0x26F4F4F4),
                    shape: OvalBorder(),
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/play-album-icon.svg",
                    // ignore: deprecated_member_use
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          name.trim(),
          style: Theme.of(context).listTileTheme.titleTextStyle,
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "$numberofsong ${numberofsong <= 1 ? "song" : "songs"}",
          style: Theme.of(context).listTileTheme.subtitleTextStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

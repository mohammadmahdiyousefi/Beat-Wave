import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_bloc.dart';
import 'package:justaudioplayer/bloc/songlist/song_list_event.dart';
import 'package:justaudioplayer/data/model/playlist.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/widget/add_to_playlist.dart';
import 'package:justaudioplayer/widget/favorit_button.dart';
import 'package:justaudioplayer/widget/song_info_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

Future<Widget?> moreBottomSheet(
  final BuildContext context,
  final SongModel song,
) {
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  final List<Widget> items = [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/add-to-album-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Add to playlist",
      ),
      onTap: () async {
        Navigator.pop(context);
        await addtoplaylistbottomshet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/trash-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Delete",
      ),
      onTap: () async {
        Navigator.pop(context);
        await addtoplaylistbottomshet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/share-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Share",
      ),
      onTap: () async {
        Navigator.pop(context);
        await Share.shareXFiles([XFile(song.data)],
            text: song.displayNameWOExt);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/Group 8.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Properties",
      ),
      onTap: () async {
        Navigator.pop(context);
        await songInfoBottomSheet(context, song);
      },
    ),
  ];
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width -
            32, // here increase or decrease in width
        maxHeight: MediaQuery.of(context).size.height * 0.4),
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: ListTile(
              shape: Theme.of(context).listTileTheme.shape,
              contentPadding: const EdgeInsets.symmetric(horizontal: 7),
              title: Text(song.title),
              titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
              subtitle: Text(song.artist ?? "<unkown>"),
              subtitleTextStyle:
                  Theme.of(context).listTileTheme.subtitleTextStyle,
              trailing: FavoritButton(
                song: song,
                color: Theme.of(context).iconTheme.color ?? Colors.grey,
              ),
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
            ),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            thickness: 1,
            height: 3,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            ),
          ),
        ],
      );
    },
  );
}

Future<Widget?> morePlaylistBottomSheet(
  final BuildContext context,
  final SongModel song,
  final int? id,
  final AudiosFromType? audiosFromType,
  final String? path,
) {
  final OnAudioQuery onAudioQuery = locator.get<OnAudioQuery>();
  final List<Widget> items = [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/trash-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Remove",
      ),
      onTap: () async {
        Navigator.pop(context);
        await PlayListHandler.removeFromPlaylist(id!, song.id).then((value) {
          if (value) {
            BlocProvider.of<SongBloc>(context)
                .add(GetSongListEvent(id, audiosFromType, path));
          } else {}
        });
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/share-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Share",
      ),
      onTap: () async {
        Navigator.pop(context);
        await Share.shareXFiles([XFile(song.data)],
            text: song.displayNameWOExt);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/add-to-album-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
      ),
      title: const Text(
        "Properties",
      ),
      onTap: () async {
        Navigator.pop(context);
        await songInfoBottomSheet(context, song);
      },
    ),
  ];
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width -
            32, // here increase or decrease in width
        maxHeight: MediaQuery.of(context).size.height * 0.4),
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: ListTile(
              shape: Theme.of(context).listTileTheme.shape,
              contentPadding: const EdgeInsets.symmetric(horizontal: 7),
              title: Text(song.title),
              titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
              subtitle: Text(song.artist ?? "<unkown>"),
              subtitleTextStyle:
                  Theme.of(context).listTileTheme.subtitleTextStyle,
              trailing: FavoritButton(
                song: song,
                color: Theme.of(context).iconTheme.color ?? Colors.grey,
              ),
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
            ),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            thickness: 1,
            height: 3,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            ),
          ),
        ],
      );
    },
  );
}

import 'package:beat_wave/bloc/playlist/playlist_bloc.dart';
import 'package:beat_wave/bloc/playlist/playlist_event.dart';
import 'package:beat_wave/bloc/songlist/song_list_bloc.dart';
import 'package:beat_wave/service/playlist_service/playlist.dart';
import 'package:beat_wave/widget/bottomsheet/add_to_playlist.dart';
import 'package:beat_wave/widget/bottomsheet/set_ringtone.dart';
import 'package:beat_wave/widget/bottomsheet/song_info_widget.dart';
import 'package:beat_wave/widget/bottomsheet/speed_bttomsheet.dart';
import 'package:beat_wave/widget/toastflutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

import '../../bloc/songlist/song_list_event.dart';

List<Widget> songItems(final BuildContext context, final SongModel song) {
  return [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/add-to-album-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Add to playlist",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await addtoplaylistbottomshet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/phone-call.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Set as Ringtone",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await setRingtoneBottomSheet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/share-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Share",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await Share.shareXFiles([XFile(song.data)], text: song.title);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/Group 8.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Properties",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await songInfoBottomSheet(context, song);
      },
    ),
  ];
}

List<Widget> songItemsPlaylist(
    final BuildContext context,
    final SongModel song,
    final int playlistid,
    final String? path,
    final AudiosFromType? audiosFromType) {
  return [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/trash-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Remove",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await PlayListHandler.removeFromPlaylist(playlistid, song.id)
            .then((value) {
          if (value) {
            BlocProvider.of<SongBloc>(context)
                .add(GetSongListEvent(playlistid, audiosFromType, path));

            toast(context, "removed from playlist successfully");
          } else {
            toast(context, "Error");
          }
        });
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/share-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Share",
        style: Theme.of(context).listTileTheme.titleTextStyle,
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
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Properties",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await songInfoBottomSheet(context, song);
      },
    ),
  ];
}

List<Widget> playlistItems(
    final BuildContext context, final PlaylistModel playlistModel) {
  return [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/trash-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Remove playlist",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        PlayListHandler.removePlaylist(playlistModel.id).then((value) {
          if (value) {
            BlocProvider.of<PlaylistBloc>(context).add(GetPlaylistEvent());
            toast(context, "removed playlist successfully");
          } else {
            toast(context, "Error");
          }
        });
      },
    ),
    // ListTile(
    //   horizontalTitleGap: 6,
    //   leading: SvgPicture.asset(
    //     "assets/svg/trash-icon.svg",
    //     // ignore: deprecated_member_use
    //     color: Theme.of(context).iconTheme.color, height: 18,
    //     width: 18,
    //   ),
    //   title: Text(
    //     "Rename playlist",
    //     style: Theme.of(context).listTileTheme.titleTextStyle,
    //   ),
    //   onTap: () async {
    //     Navigator.pop(context);
    //     PlayListHandler.renamePlaylist(playlistModel.id, "ggg");
    //   },
    // ),
  ];
}

List<Widget> playeritems(final BuildContext context, final SongModel song) {
  return [
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/add-to-album-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Add to playlist",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await addtoplaylistbottomshet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/phone-call.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Set as Ringtone",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await setRingtoneBottomSheet(context, song);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/speedometer.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Play Speed",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await playSpeedBottomSheet(context);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/share-icon.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Share",
        style: Theme.of(context).listTileTheme.titleTextStyle,
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
        color: Theme.of(context).iconTheme.color, height: 18,
        width: 18,
      ),
      title: Text(
        "Properties",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        await songInfoBottomSheet(context, song);
      },
    ),
  ];
}

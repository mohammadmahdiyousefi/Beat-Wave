import 'package:beat_wave/service/setringtone_service/set_ringtone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<Widget?> setRingtoneBottomSheet(
  final BuildContext context,
  final SongModel song,
) {
  List<Widget> items = [
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
        "Phone Ringtone",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        SetRingTone.setRingTone(context, song.data);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/alarm-clock-alt.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Alarm Ringtone",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        SetRingTone.setAlarm(context, song.data);
      },
    ),
    ListTile(
      horizontalTitleGap: 6,
      leading: SvgPicture.asset(
        "assets/svg/notification.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color,
        height: 18,
        width: 18,
      ),
      title: Text(
        "Notificaition Ringtone",
        style: Theme.of(context).listTileTheme.titleTextStyle,
      ),
      onTap: () async {
        Navigator.pop(context);
        SetRingTone.setNotification(context, song.data);
      },
    ),
  ];

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
                "Set as Ringtone",
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
              itemBuilder: (context, index) => items[index],
            ),
          ],
        ),
      );
    },
  );
}

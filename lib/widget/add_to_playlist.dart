import 'package:flutter/material.dart';
import 'package:justaudioplayer/view/addplaylistScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<Widget?> addtoplaylistbottomshet(
  BuildContext context,
  SongModel song,
) {
  DraggableScrollableController controller = DraggableScrollableController();
  return showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: Colors.transparent,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          controller: controller,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          initialChildSize: 0.6,
          expand: false,
          snap: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AddPlaylistScreen(
                      song,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

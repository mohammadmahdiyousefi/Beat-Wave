import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beat_wave/bloc/playlist/playlist_bloc.dart';
import 'package:beat_wave/bloc/playlist/playlist_event.dart';
import 'package:beat_wave/data/model/playlist.dart';

Future craetePlaylist(
  BuildContext cxt,
) {
  final TextEditingController controler = TextEditingController();

  return showDialog(
    barrierColor: Colors.transparent,
    context: cxt,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        insetPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Theme.of(context).cardColor,
              height: 165,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Create new playlist",
                          style: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SizedBox(
                      height: 36,
                      child: TextFormField(
                        autofocus: true,
                        controller: controler,
                        style: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle!
                            .copyWith(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(6),
                            hintTextDirection: TextDirection.ltr,
                            labelText: "Creat Playlist",
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Text(
                                "Cancel",
                                style: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () async {
                                await PlayListHandler.createPlaylist(
                                        controler.text)
                                    .then((value) {
                                  if (value) {
                                    BlocProvider.of<PlaylistBloc>(cxt)
                                        .add(GetPlaylistEvent());
                                  } else {}
                                  Navigator.pop(context);
                                });
                              },
                              icon: Text(
                                "Create",
                                style: Theme.of(context)
                                    .appBarTheme
                                    .titleTextStyle!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      ],
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

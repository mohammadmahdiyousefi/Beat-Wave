import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justaudioplayer/bloc/playlist/playlist_event.dart';

import '../bloc/playlist/playlist_bloc.dart';

Future addToPlaylistdiolog(BuildContext context) {
  TextEditingController controler = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.playlist_add,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Creat New Playlist',
            ),
          ],
        )),
        backgroundColor: const Color(0xff212121),
        titleTextStyle: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
        ),
        content: SizedBox(
          height: 150,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextFormField(
                  controller: controler,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      hintText: "Enter Playlist Name",
                      hintStyle: GoogleFonts.roboto(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xff2962FF),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2962FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (controler.text != '') {
                        BlocProvider.of<PlaylistBloc>(context)
                            .add(CreatPlaylistEvent(controler.text));
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Creat")),
              )
            ],
          ),
        ),
      );
    },
  );
}

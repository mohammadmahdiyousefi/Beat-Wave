import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_networc_event.dart';
import 'package:justaudioplayer/bloc/musicnetwork/music_network_bloc.dart';
import 'package:justaudioplayer/model/music.dart';
import 'package:justaudioplayer/view/networkmusicscreen.dart';

import 'aboutScreen.dart';
import 'change_theme_screen.dart';
import 'networkstream_screen.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Beat ",
                      style: Theme.of(context).textTheme.headlineLarge),
                  Text(" Wave",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20)
                      //Color.fromARGB(255, 31, 192, 36), fontSize: 25),
                      ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NetworkStreamScreen();
                    },
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.language),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Network Streram",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ChangeThemeScreen();
                    },
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.format_paint),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "Theme",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AboutScreen();
                    },
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.info),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "About",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  BlocProvider.of<MusicNetworkBloc>(context)
                      .add(MusicNetworkEvent());
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NetworkMusicScreen();
                    },
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.info),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "net",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                )),
            const Spacer(),
            Text(
              "v 1.0.1+",
              style: Theme.of(context).textTheme.displaySmall,
            )
          ],
        ),
      ),
    );
  }
}

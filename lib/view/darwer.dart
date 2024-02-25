import 'package:flutter/material.dart';
import 'package:justaudioplayer/view/app_theme_screen.dart';
import 'package:justaudioplayer/view/support_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'aboutscreen.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  // Color.fromARGB(6, 161, 127, 224),
                  // Color.fromARGB(140, 92, 38, 193),
                  // Color.fromARGB(255, 63, 43, 150),
                  Theme.of(context).colorScheme.background.withOpacity(0.2),
                  // Color.fromARGB(5, 27, 15, 255),
                  Theme.of(context).colorScheme.primary,
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app_icon/logo.png",
                  height: 150,
                  width: 150,
                ),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              snapshot.data?.appName ?? "",
                              style: const TextStyle(
                                  fontFamily: "ISW",
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'v${snapshot.data?.version ?? 0}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        );
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AppThemeScreen();
                },
              ));
            },
            leading: const Icon(
              Icons.palette_outlined,
            ),
            title: const Text(
              "App Theme",
            ),
            titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const AboutScreen();
                },
              ));
            },
            leading: const Icon(
              Icons.info_outline,
            ),
            title: const Text(
              "About",
            ),
            titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const SupportScreen();
                },
              ));
            },
            leading: const Icon(
              Icons.support_outlined,
            ),
            title: const Text(
              "Support",
            ),
            titleTextStyle: Theme.of(context).listTileTheme.titleTextStyle,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Made with    ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  "by Mohammad Mahdi    ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

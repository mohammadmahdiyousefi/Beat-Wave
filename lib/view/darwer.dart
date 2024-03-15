import 'package:flutter/material.dart';
import 'package:beat_wave/view/app_theme_screen.dart';
import 'package:beat_wave/view/support_screen.dart';
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
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                            Text(snapshot.data?.appName ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: 33,
                                        fontWeight: FontWeight.w700)),
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
            title: Text(
              "App Theme",
              style: Theme.of(context).listTileTheme.titleTextStyle,
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
            title: Text(
              "About",
              style: Theme.of(context).listTileTheme.titleTextStyle,
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
            title: Text(
              "Support",
              style: Theme.of(context).listTileTheme.titleTextStyle,
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

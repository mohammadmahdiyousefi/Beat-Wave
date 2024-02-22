import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justaudioplayer/view/app_theme_screen.dart';
import 'package:justaudioplayer/view/support_screen.dart';

import 'aboutscreen.dart';

class Drawerscreen extends StatelessWidget {
  const Drawerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Container(
                  height: 150,
                  color: Colors.transparent,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color(0xffD9D9D9),
                    child: SvgPicture.asset(
                      "assets/svg/user-icon.svg",

                      // ignore: deprecated_member_use
                      color: Colors.black,
                      height: 30,
                      width: 30,
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/user-icon.svg",
                          height: 18,
                          width: 18,
                          // ignore: deprecated_member_use
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "ورود/ثبت نام",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const AppThemeScreen();
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
                      SvgPicture.asset(
                        "assets/svg/moon-icon.svg",
                        // ignore: deprecated_member_use
                        color: Theme.of(context).iconTheme.color,
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "App Theme",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const AboutScreen();
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
                        SvgPicture.asset(
                          "assets/svg/Group 8.svg",

                          // ignore: deprecated_member_use
                          color: Theme.of(context).iconTheme.color,
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "About",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const SupportScreen();
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
                        SvgPicture.asset(
                          "assets/svg/Group 8.svg",
                          // ignore: deprecated_member_use
                          color: Theme.of(context).iconTheme.color,
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Support",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  )),
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
        ),
      ),
    );
  }
}

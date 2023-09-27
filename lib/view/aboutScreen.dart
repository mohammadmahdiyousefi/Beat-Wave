import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  String github = "https://github.com/mohammadmahdiyousefi/justaudioplayer";
  String telegram = "https://t.me/beatwavemusicplayer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "About",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            height: 150,
            width: 150,
            color: Colors.transparent,
            child: Image.asset(
              "assets/images/logo (2).png",
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Beat ", style: Theme.of(context).textTheme.headlineLarge),
                Text(" Wave",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20)
                    //Color.fromARGB(255, 31, 192, 36), fontSize: 25),
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "v1.0.0",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "This App an open-source project and can be found on ",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            width: 140,
            height: 50,
            margin: const EdgeInsets.only(top: 25, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            child: GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(github),
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.github,
                      size: 23,
                    ),
                    Text(
                      "GitHub ",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 160,
            height: 50,
            margin: const EdgeInsets.only(top: 15, bottom: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            child: GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(telegram),
                    mode: LaunchMode.externalApplication);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.telegram,
                      size: 23,
                    ),
                    Text(
                      "Telegram",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Made with    ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  "by Mohammad Mahdi    ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

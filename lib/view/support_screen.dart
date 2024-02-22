import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  final String github = "https://github.com/mohammadmahdiyousefi";
  final String telegram = "https://t.me/beatwavemusicplayer";
  final String gmail = "mailto:mmye1481@gmail.com";
  final String linkedin = "https://www.linkedin.com/in/mohammad-mahdi-yousefi/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            children: [
              SvgPicture.asset(
                "assets/svg/support.svg",
                height: 150,
                width: 150,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 16),
                child: Text(
                  "Hello, How can we Help you?",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(
                Uri.parse(github),
              )) {
                await launchUrl(
                  Uri.parse(github),
                );
              } else {
                await launchUrl(Uri.parse(github),
                    mode: LaunchMode.externalApplication);
              }
            },
            child: Card(
              elevation: 3.5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/github.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text("Git hub"),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(
                Uri.parse(linkedin),
              )) {
                await launchUrl(
                  Uri.parse(linkedin),
                );
              } else {
                await launchUrl(Uri.parse(linkedin),
                    mode: LaunchMode.externalApplication);
              }
            },
            child: Card(
              elevation: 3.5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/linkedin.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text("Linkedin"),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await launchUrl(Uri.parse("mailto:mmye1481@gmail.com"));
            },
            child: Card(
              elevation: 3.5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/google-gmail.svg",
                        height: 22.5,
                        width: 22.5,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text("Sent us an E-mail"),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(
                Uri.parse(telegram),
              )) {
                await launchUrl(
                  Uri.parse(telegram),
                );
              } else {
                await launchUrl(Uri.parse(telegram),
                    mode: LaunchMode.externalApplication);
              }
            },
            child: Card(
              elevation: 3.5,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/telegram.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text("Telegram"),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  final String buymeacoffee =
      "https://www.buymeacoffee.com/mohammadmahdiyousefi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Theme.of(context).shadowColor,
        iconTheme: Theme.of(context).iconTheme,
        //  elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: const Text("Version"),
              subtitle: const Text("Tap to check for update"),
              trailing: const Text("v0.0.1"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: const Text("share App"),
              subtitle: const Text("Let you friend share this App"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onTap: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: const Text("Liked my work ? "),
              subtitle: const Text("Buy me a coffee"),
              trailing: Image.asset(
                "assets/images/buymeacoffee.png",
                height: 25,
                width: 25,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onTap: () async {
                await launchUrl(Uri.parse(buymeacoffee));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: const Text("Donate with Gpay"),
              subtitle: const Text("Every small amount makes me smile :) "),
              trailing: const Icon(
                Icons.payment,
                color: Colors.amber,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onTap: () {},
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25),
          //   child: Text(
          //     "This App an open-source project and can be found on ",
          //     textAlign: TextAlign.center,
          //     style: Theme.of(context).textTheme.titleLarge,
          //   ),
          // ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
      )),
    );
  }
}

import 'package:beat_wave/di/di.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

Future<Widget?> playSpeedBottomSheet(
  final BuildContext context,
) {
  final AudioPlayer player = locator.get<AudioPlayer>();
  return showModalBottomSheet(
    shape: Theme.of(context).bottomSheetTheme.shape,
    elevation: Theme.of(context).bottomSheetTheme.elevation,
    backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            "Play Speed",
            style: Theme.of(context).listTileTheme.titleTextStyle,
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            thickness: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          StreamBuilder<double>(
              stream: player.speedStream,
              initialData: player.speed,
              builder: (context, snapshot) {
                final double? speed = snapshot.data;
                return Column(
                  children: [
                    Text(
                      "Speed : ${speed?.toStringAsFixed(2) ?? "1.0"} x",
                      style: Theme.of(context).listTileTheme.titleTextStyle,
                    ),
                    Slider(
                      value: speed ?? 0.5,
                      min: 0.25,
                      max: 2,
                      onChanged: (value) {
                        player.setSpeed(value);
                      },
                    ),
                  ],
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => player.setSpeed(0.25),
                  child: const Text("0.25x")),
              TextButton(
                  onPressed: () => player.setSpeed(0.5),
                  child: const Text("0.5x")),
              TextButton(
                  onPressed: () => player.setSpeed(1),
                  child: const Text("Normal")),
              TextButton(
                  onPressed: () => player.setSpeed(1.5),
                  child: const Text("1.5x")),
              TextButton(
                  onPressed: () => player.setSpeed(2),
                  child: const Text("2.0x")),
            ],
          ),
          const SizedBox(
            height: 16,
          )
        ],
      );
    },
  );
}

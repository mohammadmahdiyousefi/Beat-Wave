import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:justaudioplayer/bloc/theme/theme_event.dart';
import 'package:justaudioplayer/di/di.dart';
import 'package:justaudioplayer/view/splash_screen.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
import 'data/model/theme_class.dart';

void main() async {
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidShowNotificationBadge: true,
      preloadArtwork: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('FavoriteSongs');
  await Hive.openBox('ThemeMode');
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var themeBloc = ThemeBloc();
        themeBloc.add(InitThemeEvent());
        return themeBloc;
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp(
          themeAnimationDuration: const Duration(milliseconds: 0),
          themeMode: state.mode,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkThem,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      }),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/theme/theme_bloc.dart';
import 'package:justaudioplayer/bloc/theme/theme_event.dart';
import 'package:justaudioplayer/bloc/theme/theme_state.dart';

class AppThemeScreen extends StatelessWidget {
  AppThemeScreen({super.key});
  final List<ThemeMode> themelist = [
    ThemeMode.dark,
    ThemeMode.light,
    ThemeMode.system
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Theme",
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
            BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: themelist
                      .map(
                        (mode) => GestureDetector(
                          onTap: () {
                            if (mode == ThemeMode.dark) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(DarkThemeEvent());
                            } else if (mode == ThemeMode.light) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(LightThemeEvent());
                            } else if (mode == ThemeMode.system) {
                              BlocProvider.of<ThemeBloc>(context)
                                  .add(SystemThemeModeEvent());
                            }
                          },
                          child: Container(
                            height: 70,
                            width: 110,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              image: mode == ThemeMode.light
                                  ? const DecorationImage(
                                      image:
                                          AssetImage("assets/images/light.jpg"),
                                      fit: BoxFit.fill)
                                  : mode == ThemeMode.dark
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/dark.jpg"),
                                          fit: BoxFit.fill)
                                      : const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/auto.jpg"),
                                          fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: state.mode == mode
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                  width: 2),
                            ),
                            child: Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                  child: Container(
                                      height: 30,
                                      width: 60,
                                      color: const Color.fromARGB(
                                          35, 151, 151, 151),
                                      child: Center(
                                          child: Text(
                                        mode == ThemeMode.dark
                                            ? "Dark"
                                            : mode == ThemeMode.light
                                                ? "Light"
                                                : mode == ThemeMode.system
                                                    ? "System"
                                                    : "",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )))),
                            )),
                          ),
                        ),
                      )
                      .toList());
            }),
          ],
        ),
      ),
    );
  }
}

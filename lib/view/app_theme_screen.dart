import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/theme/theme_bloc.dart';
import 'package:justaudioplayer/bloc/theme/theme_event.dart';
import 'package:justaudioplayer/bloc/theme/theme_state.dart';

class AppThemeScreen extends StatelessWidget {
  const AppThemeScreen({super.key});

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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ThemeBloc>(context).add(DarkThemeEvent());
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: state.mode == ThemeMode.dark
                              ? Colors.deepOrange
                              : Colors.transparent),
                      child: const Center(child: Text("Dark")),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(LightThemeEvent());
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: state.mode == ThemeMode.light
                              ? Colors.deepOrange
                              : Colors.transparent),
                      margin: const EdgeInsets.all(8),
                      child: const Center(child: Text("Light")),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(SystemThemeModeEvent());
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: state.mode == ThemeMode.system
                              ? Colors.deepOrange
                              : Colors.transparent),
                      margin: const EdgeInsets.all(8),
                      child: const Center(child: Text("System")),
                    ),
                  )),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

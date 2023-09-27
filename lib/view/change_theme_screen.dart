import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';
import '../bloc/theme/theme_state.dart';

// ignore: must_be_immutable
class ChangeThemeScreen extends StatelessWidget {
  ChangeThemeScreen({super.key});

  List<String> color = [
    "fff86254",
    "ffff9a56",
    "ffffc736",
    "ffa0644c",
    "ffced515",
    "ff9fd951",
    "ff4fcd61",
    "ff18c291",
    "ff4eb3e7",
    "ff548ae2",
    "ff5368e8",
    "ff9764ed",
    "ffda55e4",
    "ffff508b",
    "fffe74591",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          "Theme",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(DarkThemeEvent());
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: state is DarkThemeState
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Dark",
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(LightThemeEvent());
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: state is LightThemeState
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Light",
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(SystemThemeModeEvent());
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: state is SystemThemeModeState
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "System",
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                          ),
                        ),
                      ],
                    ),
                    state is LightThemeState
                        ? const Icon(
                            Icons.light_mode,
                            color: Color.fromARGB(255, 255, 208, 0),
                            size: 120,
                          )
                        : state is DarkThemeState
                            ? const Icon(
                                Icons.dark_mode,
                                color: Color.fromARGB(255, 195, 228, 255),
                                size: 120,
                              )
                            : const Icon(
                                Icons.motion_photos_auto_outlined,
                                color: Color.fromARGB(255, 28, 207, 4),
                                size: 120,
                              )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Select Color",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: color.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<ThemeBloc>(context)
                              .add(SetcolorEvent(color[index]));
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(int.parse(color[index], radix: 16))),
                          child: BlocBuilder<ThemeBloc, ThemeState>(
                              builder: (context, state) {
                            if (state is DarkThemeState) {
                              return Visibility(
                                  visible: int.parse(color[index], radix: 16) ==
                                      state.color,
                                  child: const Icon(
                                    Icons.check,
                                  ));
                            } else if (state is LightThemeState) {
                              return Visibility(
                                  visible: int.parse(color[index], radix: 16) ==
                                      state.color,
                                  child: const Icon(
                                    Icons.check,
                                  ));
                            } else if (state is SystemThemeModeState) {
                              return Visibility(
                                  visible: int.parse(color[index], radix: 16) ==
                                      state.color,
                                  child: const Icon(
                                    Icons.check,
                                  ));
                            } else {
                              return Container();
                            }
                          }),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      )),
    );
  }
}

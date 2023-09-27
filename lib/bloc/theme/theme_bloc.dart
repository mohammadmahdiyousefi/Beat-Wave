import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  var thememode = Hive.box("ThemeMode");

  ThemeBloc(super.initialState) {
    on<LightThemeEvent>((event, emit) async {
      await thememode.put("mode", "light");
      var color = thememode.get("color");
      emit(LightThemeState(color));
    });
    on<DarkThemeEvent>((event, emit) async {
      await thememode.put("mode", "dark");
      var color = thememode.get("color");
      emit(DarkThemeState(color));
    });
    on<SystemThemeModeEvent>((event, emit) async {
      await thememode.put("mode", "System");
      var color = thememode.get("color");
      emit(SystemThemeModeState(color));
    });

    on<SetcolorEvent>((event, emit) async {
      await thememode.put("color", int.parse(event.color, radix: 16));
      var mode = thememode.get("mode");
      if (mode == "dark") {
        emit(DarkThemeState(int.parse(event.color, radix: 16)));
      } else if (mode == "light") {
        emit(LightThemeState(int.parse(event.color, radix: 16)));
      } else {
        emit(SystemThemeModeState(int.parse(event.color, radix: 16)));
      }
    });
  }
}

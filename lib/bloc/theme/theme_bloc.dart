import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  var thememode = Hive.box("ThemeMode");
  ThemeBloc() : super(const SystemThemeModeState(ThemeMode.system)) {
    on<InitThemeEvent>((event, emit) async {
      // var color = thememode.get("color") ?? int.parse("ffAA00FF", radix: 16);
      if (thememode.get("mode") == "Dark") {
        emit(const DarkThemeState(ThemeMode.dark));
      } else if (thememode.get("mode") == "Light") {
        emit(const LightThemeState(ThemeMode.light));
      } else if (thememode.get("mode") == "System") {
        emit(const SystemThemeModeState(
          ThemeMode.system,
        ));
      } else {
        emit(const SystemThemeModeState(ThemeMode.system));
      }
    });
    on<LightThemeEvent>((event, emit) async {
      await thememode.put("mode", "Light");

      emit(const LightThemeState(ThemeMode.light));
    });
    on<DarkThemeEvent>((event, emit) async {
      await thememode.put("mode", "Dark");
      emit(const DarkThemeState(ThemeMode.dark));
    });
    on<SystemThemeModeEvent>((event, emit) async {
      await thememode.put("mode", "System");
      emit(const SystemThemeModeState(
        ThemeMode.system,
      ));
    });

    on<SetcolorEvent>((event, emit) async {
      await thememode.put("color", int.parse(event.color, radix: 16));
      var mode = thememode.get("mode");
      if (mode == "dark") {
        emit(const DarkThemeState(ThemeMode.dark));
      } else if (mode == "light") {
        emit(const LightThemeState(ThemeMode.light));
      } else {
        emit(const SystemThemeModeState(ThemeMode.system));
      }
    });
  }
}

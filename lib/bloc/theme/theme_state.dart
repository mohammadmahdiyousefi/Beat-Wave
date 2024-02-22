import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode mode;
  const ThemeState(this.mode);
  @override
  List<Object> get props => [mode];
}

class LightThemeState extends ThemeState {
  const LightThemeState(super.mode);
  @override
  List<Object> get props => [mode];
}

class DarkThemeState extends ThemeState {
  const DarkThemeState(super.mode);
  @override
  List<Object> get props => [mode];
}

class SystemThemeModeState extends ThemeState {
  const SystemThemeModeState(super.mode);
  @override
  List<Object> get props => [mode];
}

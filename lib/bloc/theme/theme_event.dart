abstract class ThemeEvent {}

class LightThemeEvent extends ThemeEvent {}

class DarkThemeEvent extends ThemeEvent {}

class SystemThemeModeEvent extends ThemeEvent {}

class SetcolorEvent extends ThemeEvent {
  String color;
  SetcolorEvent(this.color);
}

abstract class ThemeState {}

class LightThemeState extends ThemeState {
  int color;
  LightThemeState(this.color);
}

class DarkThemeState extends ThemeState {
  int color;
  DarkThemeState(this.color);
}

class SystemThemeModeState extends ThemeState {
  int color;
  SystemThemeModeState(this.color);
}

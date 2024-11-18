part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class DarkTheme extends ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDark;
  ThemeChanged({required this.isDark});
}

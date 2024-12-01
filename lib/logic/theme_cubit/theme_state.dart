part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeData themeData;

  ThemeChanged(this.themeData);
}

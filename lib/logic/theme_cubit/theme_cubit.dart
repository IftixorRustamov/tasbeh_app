import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadTheme();
  }

  void toggleTheme() async {
    final currentTheme = (state is ThemeChanged)
        ? (state as ThemeChanged).themeData
        : ThemeData.light();

    final newTheme = (currentTheme.brightness == Brightness.light)
        ? ThemeData.dark()
        : ThemeData.light();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme.brightness == Brightness.dark);

    emit(ThemeChanged(newTheme));
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
    emit(ThemeChanged(themeData));
  }
}

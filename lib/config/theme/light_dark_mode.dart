import 'package:flutter/material.dart';
import 'colors.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  cardColor: MyColors.white,
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColors.silver,
  iconTheme: const IconThemeData(color: MyColors.grey),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: MyColors.black),
    bodyMedium: TextStyle(color: MyColors.lightGrey),
    titleMedium: TextStyle(color: MyColors.lightGrey),
    titleLarge: TextStyle(color: MyColors.black),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.silver,
    iconTheme: IconThemeData(color: MyColors.white),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: MyColors.blue,
    onPrimary: MyColors.lightGrey,
    secondary: MyColors.silver,
    onSecondary: MyColors.black,
    error: MyColors.red,
    onError: MyColors.white,
    surface: MyColors.white,
    onSurface: MyColors.black,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  cardColor: MyColors.lightGrey,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.darkGrey,
  iconTheme: const IconThemeData(color: MyColors.white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: MyColors.white),
    bodyMedium: TextStyle(color: MyColors.silver),
    titleMedium: TextStyle(color: MyColors.silver),
    titleLarge: TextStyle(color: MyColors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.darkGrey,
    iconTheme: IconThemeData(color: MyColors.white),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: MyColors.darkGreen,
    onPrimary: MyColors.lightGrey,
    secondary: MyColors.lightGrey,
    onSecondary: MyColors.black,
    error: MyColors.red,
    onError: MyColors.white,
    surface: MyColors.lightGrey,
    onSurface: MyColors.silver,
  ),
);

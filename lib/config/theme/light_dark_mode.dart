import 'package:flutter/material.dart';
import 'colors.dart';

// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: MyColors.silver,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.silver,
    iconTheme: IconThemeData(color: MyColors.white),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: MyColors.black),
    bodyMedium: TextStyle(color: MyColors.black),
    titleLarge: TextStyle(color: MyColors.black),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: MyColors.blue,
    onPrimary: MyColors.white,
    secondary: MyColors.silver,
    onSecondary: MyColors.black,
    error: MyColors.red,
    onError: MyColors.white,
    surface: MyColors.silver,
    onSurface: MyColors.black,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: MyColors.grey,
  appBarTheme: AppBarTheme(
    backgroundColor: MyColors.darkGrey,
    iconTheme: IconThemeData(color: MyColors.white),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: MyColors.white),
    bodyMedium: TextStyle(color: MyColors.white),
    titleLarge: TextStyle(color: MyColors.white),
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.deepOrangeAccent,
    onPrimary: MyColors.white,
    secondary: MyColors.lightGrey,
    onSecondary: MyColors.black,
    error: MyColors.red,
    onError: MyColors.white,
    surface: MyColors.grey,
    onSurface: MyColors.white,
  ),
);

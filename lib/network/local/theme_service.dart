import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_setu/res/app_color.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  late SharedPreferences storage;

  // Custom dark theme
  final darkTheme = ThemeData(
    primarySwatch: AppColor.primarySwatchColor, // Use your custom primary color here
    brightness: Brightness.dark,
    primaryColorDark: AppColor.primaryDark, // Set the dark variant of your color
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey[800],
    canvasColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white, fontSize: 20),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[800],
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white70),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  // Custom light theme
  final lightTheme = ThemeData(
    primarySwatch: AppColor.primarySwatchColor, // Use your custom primary color here
    brightness: Brightness.light,
    primaryColor: AppColor.primary, // Set the main primary color
    primaryColorDark: AppColor.primaryDark, // Set the dark variant of your color
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey[50],
    canvasColor: Colors.grey[100],

    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.black, fontSize: 20),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.primary, // Use primary color for buttons
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColor.primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primary, // Use primary color for buttons
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColor.primary,
        side: BorderSide(color: AppColor.primary),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  // Dark mode toggle action
  changeTheme() {
    _isDark = !_isDark;

    // Save the value to shared preferences
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  // Initialize the theme and load stored preference
  init() async {
    // Ensure SharedPreferences is loaded before proceeding
    storage = await SharedPreferences.getInstance();

    // Get the saved theme preference, default to light theme (false)
    _isDark = storage.getBool("isDark") ?? false;

    // Notify listeners to update the theme
    notifyListeners();
  }

  // Optional: A method to force a theme set, in case you want to override current theme
  setTheme(bool isDarkMode) {
    _isDark = isDarkMode;
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }
}

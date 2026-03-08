import 'package:runshaw/utils/theme/dark.dart';
import 'package:runshaw/utils/theme/light.dart';
import 'package:runshaw/utils/theme/amoled.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late bool amoledEnabled = false;
  late String currentScheme = 'light';

  final themes = {['light']: lightColourScheme, ['dark']: darkColourScheme, ['amoled']: amoledColourScheme};
  final lightThemes = ['light'];
  final darkThemes = ['dark', 'amoled'];

  late ColorScheme? currentColorScheme;

  Future<void> initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');

    if (theme == null) {
      theme = 'light';
      prefs.setString('theme','light');
    }

    currentColorScheme = themes[theme];

    notifyListeners();
  }

  Future<void> setThemeMode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', value);
    currentScheme = value;
    currentColorScheme = themes[value];

    notifyListeners();
  }

  bool get isLightMode => lightThemes.contains(currentScheme);
  bool get isDarkMode => darkThemes.contains(currentScheme);
}

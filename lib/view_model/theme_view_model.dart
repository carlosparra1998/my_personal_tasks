import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/strings.dart' as s;

class ThemeVM with ChangeNotifier {
  bool _darkTheme;

  Color themeColor;
  Color fontColor;
  Color subtitleColor;
  Color cardColor;
  Color iconColor;
  Color buttonColor;

  ThemeVM(this._darkTheme, this.themeColor, this.fontColor, this.subtitleColor, this.cardColor, this.iconColor, this.buttonColor);

  get getDarkTheme => _darkTheme;

  Future<void> changeTheme() async {
    var prefs = await SharedPreferences.getInstance();
    
    _darkTheme = !_darkTheme;
    themeColor = (_darkTheme) ? const Color.fromARGB(255, 46, 46, 46) : Colors.white;
    fontColor = (_darkTheme) ? Colors.white : Colors.black;
    cardColor = (_darkTheme) ? const Color.fromARGB(255, 88, 88, 88) : Colors.white;
    subtitleColor = (_darkTheme)
        ? const Color.fromARGB(255, 185, 185, 185)
        : const Color.fromARGB(255, 139, 139, 139);
    iconColor = (_darkTheme) ? Colors.black : Colors.white;
    buttonColor =
        (_darkTheme) ? const Color.fromARGB(255, 255, 212, 212) : Colors.red;

    prefs.setBool(s.darkThemeKey, _darkTheme);

    notifyListeners();
  }
}

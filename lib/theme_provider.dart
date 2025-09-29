// lib/models/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _mode = _fromString(prefs.getString('themeMode') ?? 'system');
    notifyListeners();
  }

  Future<void> toggle() async {
    switch (_mode) {
      case ThemeMode.light: _mode = ThemeMode.dark; break;
      case ThemeMode.dark: _mode = ThemeMode.system; break;
      case ThemeMode.system: _mode = ThemeMode.light; break;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _toString(_mode));
    notifyListeners();
  }

  String _toString(ThemeMode m) =>
      m == ThemeMode.light ? 'light' : m == ThemeMode.dark ? 'dark' : 'system';

  ThemeMode _fromString(String s) =>
      s == 'light' ? ThemeMode.light : s == 'dark' ? ThemeMode.dark : ThemeMode.system;
}

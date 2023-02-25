import 'package:flutter/material.dart';

import '../../core/app_prefs.dart';
import '../../core/services/service_locator.dart';

class ThemeManager with ChangeNotifier {

  final AppPreferences _appPreferences = sl<AppPreferences>();

  ThemeMode _themeData = ThemeMode.light;

  get themeMode => _themeData;

  toggleTheme(bool isDark) {
    _themeData = isDark ? ThemeMode.dark : ThemeMode.light;
    _appPreferences.changeTheme(isDark);
    notifyListeners();
  }
}

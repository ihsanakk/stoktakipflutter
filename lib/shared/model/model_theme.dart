import 'package:flutter/cupertino.dart';
import 'package:stoktakip/core/cache_manager.dart';

class ModelTheme extends ChangeNotifier with CacheManager {
  late bool _isDark;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await getTheme();
    notifyListeners();
  }
}

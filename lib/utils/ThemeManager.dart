import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dade_cho/utils/AppTheme.dart';
import 'package:flutter_dade_cho/utils/StorageManager.dart';

class ThemeNotifier with ChangeNotifier {

  ThemeData? _themeData;

  ThemeNotifier() {
    StorageManager.readPref('themeMode').then((value) {
      print('value read from storage: $value');
      //if not stored (first time opening app)
      if(value == null){
        //looking at system pref and saving it
        SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? setDarkMode() : setLightMode();
      }
      else{
        if (value == 'light') {
          _themeData = AppTheme.lightTheme;
        } else {
          print('setting dark theme');
          _themeData = AppTheme.darkTheme;
        }
      }
      notifyListeners();
    });
  }

  ThemeData? getTheme() => _themeData;

  bool getValue() {
    return _themeData == AppTheme.lightTheme;
  }

  void setValue(bool value){
    value ? setLightMode() : setDarkMode();
  }
  void change(){
    _themeData == AppTheme.lightTheme ? setDarkMode() : setLightMode();
  }

  void setDarkMode() async {
    _themeData = AppTheme.darkTheme;
    StorageManager.savePref('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = AppTheme.lightTheme;
    StorageManager.savePref('themeMode', 'light');
    notifyListeners();
  }
}
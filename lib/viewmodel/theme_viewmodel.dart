import 'package:flutter/material.dart';
import 'package:zyl_app2/global/global_theme.dart';

class ThemeViewModel extends ChangeNotifier {
  int _color = 0;

  int get getColor {
    print("color：++++：$_color}");
    return _color;
  }
  void setColor(int color) {
    if(color > themes.length - 1) return;
    _color = color;
    print("setColor：++++：$_color}");
    notifyListeners();
  }

}
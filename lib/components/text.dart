import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {

  static double _fontSize = 0.5;
  Widget _passedWidget;
  bool _isSwitchOn = false;

// to get and set new widgets
  get passedWidget => _passedWidget;
  get isSwitchOn => _isSwitchOn;

  set passedWidget(newWidget) {
    _passedWidget = newWidget;
    notifyListeners();
  }

  set isSwitchOn(newValue) {
    _isSwitchOn = newValue;
    notifyListeners();
  }

// to get and set font size
  set fontSize(newValue) {
    _fontSize = newValue;
    notifyListeners();
  }

  double get fontSize => _fontSize * 30;
  double get sliderFontSize => _fontSize;
}

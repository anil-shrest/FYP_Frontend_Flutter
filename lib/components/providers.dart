import 'package:flutter/material.dart';

class Providers extends ChangeNotifier {
  int _indexValue;

  int get indexValue => _indexValue;

  indexValues(int value) {
    _indexValue = value;
    notifyListeners();
  }
}

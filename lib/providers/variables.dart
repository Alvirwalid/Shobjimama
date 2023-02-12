import 'package:flutter/material.dart';

class StringProvider extends ChangeNotifier {
  // create a common file for data
  String _str = '1.0';

  String get str => _str;

  void setPrice(String st) {
    _str = st;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class LangProvider with ChangeNotifier {
  String _locale = "default";
  Map<String, Map<String, dynamic>> _map = {};

  get locale => _locale;

  setLocale(value) {
    _locale = value;
    notifyListeners();
  }

  get map => _map;

  set map(value) {
    _map = value;
    notifyListeners();
  }
}

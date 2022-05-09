import 'dart:convert';
import 'package:flutter/services.dart';

class CustomLocale {
  final String key;
  final String file;

  CustomLocale({required this.key, required this.file});
}

List<CustomLocale> locales = [
  CustomLocale(key: "tm", file: "assets/locales/tm.json"),
  CustomLocale(key: "en", file: "assets/locales/en.json"),
  CustomLocale(key: "ru", file: "assets/locales/ru.json"),
];

Future<Map<String, dynamic>> readJson(String jsonPath) async {
  final String response = await rootBundle.loadString(jsonPath);
  final data = await json.decode(response);
  return data;
}

class LocalizationInit {
  static Future loadLocalization() async {
    Map<String, Map<String, dynamic>> result = {};

    for (CustomLocale locale in locales) {
      result[locale.key] = await readJson(locale.file);
    }

    return result;
  }
}

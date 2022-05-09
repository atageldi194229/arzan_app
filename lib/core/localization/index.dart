import 'package:tm/core/localization/lang_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './langs.dart';
export './lang_provider.dart';

class TT {
  static String tt(BuildContext context, String key) {
    String locale = context.watch<LangProvider>().locale;
    Map<String, Map<String, dynamic>> map = context.watch<LangProvider>().map;

    if (!map.containsKey(locale)) return key;

    if (!map[locale]!.containsKey(key)) return key;

    return map[locale]![key]!.toString();
  }

  static void init(BuildContext context) {
    LocalizationInit.loadLocalization().then((res) {
      String firstKey = res.keys.toList().first;

      context.read<LangProvider>().map = res;
      context.read<LangProvider>().locale = firstKey;
    });
  }
}

extension TTranslateString on String {
  String tt(BuildContext context) {
    return TT.tt(context, this);
  }
}

extension TTranslateContext on BuildContext {
  String tt(String key) {
    return TT.tt(this, key);
  }

  List<String> ttLocales() {
    return watch<LangProvider>().map.keys.toList();
  }

  /// to change current language\
  /// Example:
  /// ```dart
  ///   context.ttChangeLocale("en");
  /// ```
  void ttChangeLocale(String locale) {
    read<LangProvider>().locale = locale;
  }
}

class TTranslate extends StatelessWidget {
  final Widget child;
  const TTranslate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TT.init(context);
    return child;
  }
}

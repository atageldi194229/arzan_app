import 'package:tm/core/localization/index.dart';
import 'package:flutter/material.dart';

const String test = "Test string branch two (test)";

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(TT.tt(context, "locale")),
          Text("locale".tt(context)),
          Text(context.tt("locale")),
          ...context.ttLocales().map(
                (locale) => ElevatedButton(
                  onPressed: () => context.ttChangeLocale(locale),
                  child: Text(locale),
                ),
              ),
        ],
      ),
    );
  }
}

import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> locales = context.ttLocales();

    Map<String, String> localeDesctiption = {
      "en": "English",
      "tm": "Turkmen",
      "ru": "Russian",
    };

    return ExpansionTile(
      leading: const Icon(
        Icons.translate_rounded,
        color: kSoftGreen,
      ),
      title: Text(context.tt("language")),
      children: List.generate(
        locales.length,
        (index) {
          return ListTile(
            onTap: () => context.ttChangeLocale(locales[index]),
            title: Text(
              localeDesctiption[locales[index]]!,
              style: context.ttCurrentLocale == locales[index]
                  ? const TextStyle(color: kSoftGreen)
                  : null,
            ),
          );
        },
      ),
    );
  }
}

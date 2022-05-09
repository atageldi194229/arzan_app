import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      leading: Icon(
        Icons.translate_rounded,
        color: kSoftGreen,
      ),
      title: Text('Language'),
      children: [
        ListTile(
          title: Text('Turkmen'),
        ),
        ListTile(
          title: Text('Russian'),
        ),
        ListTile(
          title: Text('English'),
        ),
      ],
    );
  }
}

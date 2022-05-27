import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';

void showDialogOnDevelopment(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: const [
            Text(
              'Iň ýakyn wagtda',
              style: TextStyle(
                color: kSoftGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.build_circle_outlined,
              color: kSoftGreen,
              size: 40,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(' - Bu bölüm(gural) häzirki wagtda işlenmäge dowam etýär.'),
              Text(''),
              Text(' - Iň soňky wersiýalaryndan habarly '
                  'bolup durmagyňyzy ýatlatýarys :)'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Düşnükli'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

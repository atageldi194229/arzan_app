import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/login/login_screen.dart';
import 'package:tm/ui/size_config.dart';

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

void showDialogToLogin(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
            'Ulgama girmedigiňiz sebäpli bu mümkinçilik elýeterli däl!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: const Text('Ulgama girmek'),
          )
        ],
      );
    },
  );
}

void showDialogSuccess(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.of(context).pop(true);
        },
      );
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/success.png',
                  width: SizeConfig.screenWidth * 0.3,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Üstünlikli amala aşdy!!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void showDialogFailed(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.of(context).pop(true);
        },
      );
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/red-x.png',
                  width: SizeConfig.screenWidth * 0.3,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Gynansakda yalnys!!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void showDialogNewVersionAvailable(
  BuildContext context, {
  String? notes,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: const [
            Text(
              'Update!!!',
              style: TextStyle(
                color: kSoftGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.update_rounded,
              color: kSoftGreen,
              size: 40,
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              if (notes != null) Text(notes),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              // const String appPackageName = 'afisha.arzan.tm';

              try {
                StoreRedirect.redirect();
              } catch (_) {}
            },
          ),
        ],
      );
    },
  );
}

void showDialogAfterRegister(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
          'Ulgama girmedigiňiz sebäpli bu mümkinçilik elýeterli däl!',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: const Text('Ulgama girmek'),
          )
        ],
      );
    },
  );
}

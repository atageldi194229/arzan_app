import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/screens/register/components/body.dart';
import "package:flutter/material.dart";
import 'package:tm/ui/widgets/default_appbar.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: context.tt('register')),
      body: const Body(),
    );
  }
}

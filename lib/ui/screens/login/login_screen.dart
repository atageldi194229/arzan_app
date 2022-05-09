import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

import './components/body.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: DefaultAppBar(title: 'Login'),
      body: Body(),
    );
  }
}

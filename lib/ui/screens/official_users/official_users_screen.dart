import 'package:flutter/material.dart';
import './components/body.dart';

class OfficialUsersScreen extends StatelessWidget {
  static const routeName = '/official_users';
  const OfficialUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}

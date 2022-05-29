import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import './components/body.dart';

class ProfileSettingScreen extends StatelessWidget {
  static String routeName = '/profile_setting';
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "Profile setting"),
      body: Body(),
    );
  }
}

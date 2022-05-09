import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/default_appbar.dart';

import 'components/body.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: DefaultAppBar(title: 'Notifications'),
      body: Body(),
    );
  }
}

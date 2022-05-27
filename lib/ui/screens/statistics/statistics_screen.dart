import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

import './components/body.dart';

class StatisticsScreen extends StatelessWidget {
  static const routeName = '/statistics';
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: 'Statistics'),
      backgroundColor: kScaffoldColor,
      body: Body(),
    );
  }
}

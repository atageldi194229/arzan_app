import "package:flutter/material.dart";
import "package:tm/ui/size_config.dart";

import "./components/body.dart";

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}

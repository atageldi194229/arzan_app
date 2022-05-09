import 'package:tm/ui/screens/contact_us/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/default_appbar.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact_us';

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Habarlasmak'),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

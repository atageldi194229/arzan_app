import 'package:tm/ui/screens/contact_us/components/body.dart';
import 'package:flutter/material.dart';

import '../../widgets/default_appbar.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact_us';

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: 'Habarlasmak'),
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

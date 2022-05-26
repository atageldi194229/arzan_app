import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/custom_drawer.dart';
import 'package:tm/ui/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:tm/ui/enums.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";

  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
        extendBody: true,
        backgroundColor: kScaffoldColor,
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.search),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: CustomFloatingActionButton(),
        drawer: CustomDrawer(),
      ),
    );
  }
}

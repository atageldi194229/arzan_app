import 'package:tm/core/providers/recommended_post_provider.dart';
import 'package:tm/core/utils/new_version_util.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/custom_drawer.dart';
import 'package:tm/ui/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:tm/ui/enums.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    newVersionCheck(context);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<RecommendedPostProvider>().loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Body(),
        extendBody: true,
        backgroundColor: kScaffoldColor,
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: CustomFloatingActionButton(),
        drawer: CustomDrawer(),
      ),
    );
  }
}

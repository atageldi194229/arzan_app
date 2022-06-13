import 'package:flutter/material.dart';
import 'package:tm/ui/enums.dart';
import 'package:tm/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:tm/ui/widgets/custom_drawer.dart';
import 'package:tm/ui/widgets/custom_floating_action_button.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import './components/body.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: "Message",
        backgroundChange: true,
      ),
      body: Body(),
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: CustomFloatingActionButton(),
      drawer: CustomDrawer(),
    );
  }
}

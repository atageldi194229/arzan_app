import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/providers/official_user_list_provider.dart';
import 'package:tm/ui/enums.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:tm/ui/widgets/custom_drawer.dart';
import 'package:tm/ui/widgets/custom_floating_action_button.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import './components/body.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      context.read<OfficialUserListProvider>().load();
    });
  }

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

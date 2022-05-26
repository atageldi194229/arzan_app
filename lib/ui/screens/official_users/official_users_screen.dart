import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/providers/official_user_list_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import './components/body.dart';

class OfficialUsersScreen extends StatefulWidget {
  static const routeName = '/official_users';
  const OfficialUsersScreen({Key? key}) : super(key: key);

  @override
  State<OfficialUsersScreen> createState() => _OfficialUsersScreenState();
}

class _OfficialUsersScreenState extends State<OfficialUsersScreen> {
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
      backgroundColor: kScaffoldColor,
      body: Body(),
    );
  }
}

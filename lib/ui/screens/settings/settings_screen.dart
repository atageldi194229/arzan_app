import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/settings/components/language_tile.dart';
import 'package:tm/ui/screens/settings/components/notification_tile.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: const DefaultAppBar(title: 'Settings'),
      body: ListView(
        children: [
          Container(
            width: _size.width,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                boxShadow: kBoxShadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const NotificationTile(),
                const LanguageTile(),
                SettingTile(
                    icon: Icons.location_pin,
                    title: 'Select your region',
                    onTap: () {}),
                SettingTile(icon: Icons.list, title: 'Rules', onTap: () {}),
                SettingTile(
                    icon: Icons.credit_card_rounded,
                    title: 'Online payment',
                    onTap: () {}),
                SettingTile(
                    icon: Icons.arrow_downward_rounded,
                    title: 'Download',
                    onTap: () {}),
                SettingTile(
                    icon: Icons.exit_to_app,
                    title: 'Exit',
                    onTap: () => SystemNavigator.pop()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SettingTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kSoftGreen),
      title: Text(title),
    );
  }
}

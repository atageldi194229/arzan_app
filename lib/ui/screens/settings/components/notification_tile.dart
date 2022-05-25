import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class NotificationTile extends StatefulWidget {
  const NotificationTile({Key? key}) : super(key: key);

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications_outlined, color: kSoftGreen),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.tt('notification'),
          ),
          PlatformSwitch(
              value: isNotificationOn,
              onChanged: (v) => setState(() => isNotificationOn = v)),
        ],
      ),
    );
  }
}

class PlatformSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const PlatformSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSwitch(value: value, onChanged: onChanged);
    }
    return Switch(value: value, activeColor: kSoftGreen, onChanged: onChanged);
  }
}

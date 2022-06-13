import 'package:flutter/material.dart';
import './components/body.dart';

class UserChatScreen extends StatelessWidget {
  static String routeName = '/user-chat';

  const UserChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppBar(),
      body: Body(),
    );
  }
}

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Rustem ussa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Was online Match 18  09:03',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_vert)
        ],
      ),
      leading: LayoutBuilder(
        builder: (context, constraints) {
          return IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: constraints.biggest.width / 1.5,
            ),
          );
        },
      ),
    );
  }
}

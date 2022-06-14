import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/size_config.dart';
import './components/body.dart';

class UserChatScreen extends StatelessWidget {
  static String routeName = '/user-chat';

  const UserChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ChatAppBar(),
      body: Body(),
      floatingActionButton: UserChatBottomForm(),
    );
  }
}

class UserChatBottomForm extends StatelessWidget {
  const UserChatBottomForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Your sms",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(20),
                      vertical: getProportionateScreenWidth(15),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                color: kSoftGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: SizeConfig.screenWidth * 0.09,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.add_reaction_outlined),
            Icon(Icons.image),
            Icon(Icons.add_reaction_outlined),
          ],
        )
      ],
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
          const Spacer(),
          const Icon(Icons.more_vert)
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/providers/notification_provider.dart';
import 'package:tm/core/providers/official_user_list_provider.dart';
import 'package:tm/ui/components/official_user.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/chat/user_chat/chat_user_screen.dart';
import 'package:tm/ui/screens/notification_detail/notification_detail_screen.dart';
import 'package:tm/ui/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.atEdge) {
        bool isTop = controller.position.pixels == 0;
        if (!isTop) {
          context.read<OfficialUserListProvider>().load();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    OfficialUserListProvider provider =
        context.watch<OfficialUserListProvider>();

    List<UserModel> officials = provider.items;

    if (officials.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      // physics: ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(30),
              vertical: getProportionateScreenHeight(30),
            ),
            child: Row(
              children: const [
                Text(
                  'Online(0)',
                  style: TextStyle(
                      color: kSoftGreen,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
                Spacer(),
                Text(
                  'Ofline(0)',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            controller: controller,
            itemCount: officials.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => UserListChat(
              officials[index],
              onTap: () {
                // context.read<NotificationProvider>().currentIndex = index;
                Navigator.pushNamed(context, UserChatScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserListChat extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserListChat(
    this.user, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
        child: Container(
          margin:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(8)),
          child: Row(
            children: [
              user.image == null
                  ? const DefaultOfficalUserIcon()
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: user.image,
                        width: SizeConfig.screenWidth * 0.23,
                        height: SizeConfig.screenWidth * 0.23,
                        fit: BoxFit.cover,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(50),
                  left: getProportionateScreenWidth(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    const Text("message"),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: getProportionateScreenHeight(50),
                ),
                child: const Text(
                  '6 february, 23:17',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

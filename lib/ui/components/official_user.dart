import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/screens/profile/profile_screen.dart';

import '../constants.dart';

class OfficialUser extends StatelessWidget {
  final bool iconShow;
  final UserModel user;

  const OfficialUser(
    this.user, {
    Key? key,
    this.iconShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double iconSize = constraints.maxWidth * 0.18;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: kBorderRadius,
            boxShadow: kBoxShadow,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ProfileScreen.routeName,
                        arguments: ProfileScreenArguments(
                          loadUser: () =>
                              AccountService().fetchData(userId: user.id),
                        ),
                      );
                      // showDialogOnDevelopment(context);
                    },
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          user.image == null
                              ? const DefaultOfficalUserIcon()
                              : CachedNetworkImage(
                                  imageUrl: user.image,
                                  width: constraints.maxWidth,
                                  height: constraints.maxWidth,
                                  fit: BoxFit.contain,
                                ),
                          Positioned(
                            child: Image.asset(
                              'assets/images/official_icon.png',
                              width: iconSize,
                              height: iconSize,
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  Text(
                    user.username,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FollowStatusWidget(user.id),
                ],
              ),
              if (iconShow)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/icon_notification.png',
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            4.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class FollowStatusWidget extends StatelessWidget {
  final int userId;

  const FollowStatusWidget(
    this.userId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFollowing = false;

    var user = context.watch<AccountProvider>().user;

    if (user != null) {
      isFollowing = user.followingIdList.contains(userId);
    }

    String buttonText = 'Follow';
    if (isFollowing) buttonText = 'Unfollow';

    bool isUserLoggedIn = context.watch<AuthProvider>().isLoggedIn;

    return DefaultButtonGreen(
        text: buttonText,
        active: !isFollowing,
        press: () {
          // debugPrint('follow $userId $isFollowing');
          if (isUserLoggedIn) {
            context.read<AccountProvider>().follow(userId, !isFollowing);
          } else {
            showDialogToLogin(context);
          }
        });
  }
}

class DefaultOfficalUserIcon extends StatelessWidget {
  const DefaultOfficalUserIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Image.asset(
        'assets/images/user_icon.png',
        width: MediaQuery.of(context).size.width / 4,
      ),
    );
  }
}

import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/chat/chat_main/chat_main_screen.dart';
import 'package:tm/ui/screens/login/login_screen.dart';
import 'package:tm/ui/screens/profile/profile_screen.dart';
import 'package:tm/ui/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  Color _getIconColor(MenuState menuState) {
    if (menuState == selectedMenu) {
      return kSoftGreen;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    Radius radius = const Radius.circular(25);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: radius,
            topRight: radius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: _NavbarItem(
                child: SvgPicture.asset(
                  'assets/icons/fi-rr-drawer.svg',
                  width: MediaQuery.of(context).size.width / 10,
                  color: _getIconColor(MenuState.drawer),
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: _NavbarItem(
                child: SvgPicture.asset(
                  'assets/icons/fi-rr-search.svg',
                  width: MediaQuery.of(context).size.width / 10,
                  color: _getIconColor(MenuState.search),
                ),
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: _NavbarItem(
                child: SvgPicture.asset(
                  'assets/icons/fi-rr-home.svg',
                  width: MediaQuery.of(context).size.width / 10,
                  color: _getIconColor(MenuState.home),
                ),
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Builder(builder: (context) {
                var authProvider = context.watch<AuthProvider>();

                return _NavbarItem(
                  child: SvgPicture.asset(
                    'assets/icons/fi-rr-user.svg',
                    width: MediaQuery.of(context).size.width / 25,
                    color: _getIconColor(MenuState.profile),
                  ),
                  onTap: () {
                    if (authProvider.isLoggedIn) {
                      // var userId = context.read<AuthProvider>().userId;
                      // context.read<AccountProvider>().initUser(
                      //       userId: auth.userId,
                      //     );
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushNamed(
                        context,
                        ProfileScreen.routeName,
                        arguments: ProfileScreenArguments(
                          mode: ProfileScreenMode.profile,
                          loadUser: () => AccountService()
                              .fetchData(userId: authProvider.userId),
                        ),
                      );
                    } else {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }
                  },
                );
              }),
            ),
            Expanded(
              flex: 5,
              child: _NavbarItem(
                child: Icon(
                  Icons.chat,
                  color: _getIconColor(MenuState.payment),
                ),
                onTap: () {
                  Navigator.pushNamed(context, ChatScreen.routeName);
                },
              ),
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}

class _NavbarItem extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _NavbarItem({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}

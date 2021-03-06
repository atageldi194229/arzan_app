import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/screens/about_us/about_us_screen.dart';
import 'package:tm/ui/screens/contact_us/contact_us_screen.dart';
import 'package:tm/ui/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String appPackageName = 'afisha.arzan.tm';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  _onShareTap() {
    if (Platform.isIOS) {
      Share.share("market://details?id=$appPackageName");
    } else {
      Share.share(
          "https://play.google.com/store/apps/details?id=$appPackageName");
    }
  }

  _onRateUsTap() {
    // try {
    //   launchUrl(Uri.parse("market://details?id=$appPackageName"));
    // } on PlatformException {
    //   launchUrl(Uri.parse(
    //       "https://play.google.com/store/apps/details?id=$appPackageName"));
    // } finally {
    //   launchUrl(Uri.parse(
    //       "https://play.google.com/store/apps/details?id=$appPackageName"));
    // }

    try {
      StoreRedirect.redirect();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child:
                DrawerHeader(child: Image.asset('assets/images/logo_app.png')),
          ),
          Expanded(
            flex: 14,
            child: Column(
              children: [
                DrawerItem(
                  title: context.tt('navAboutUs'),
                  icon: Icons.info_outline,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AboutUsScreen.routeName);
                  },
                  // onTap: () => MyRouter().route(context, const AboutPage()),
                ),
                // DrawerItem(
                //   title: context.tt('navPayment'),
                //   icon: Icons.credit_card_rounded,
                //   onTap: () {},
                //   //     .route(context, const PaymentPage(content: FirstStep())),
                //   // onTap: () => MyRouter()
                // ),
                DrawerItem(
                  title: context.tt('navShare'),
                  icon: Icons.share_outlined,
                  onTap: () {
                    _onShareTap();
                  },
                ),
                DrawerItem(
                  title: context.tt('navContactUs'),
                  icon: Icons.headset_mic_outlined,
                  onTap: () =>
                      Navigator.pushNamed(context, ContactUsScreen.routeName),
                  // onTap: () => MyRouter().route(context, const ContactUsPage()),
                ),
                DrawerItem(
                  title: context.tt('navRateUs'),
                  icon: Icons.star_border_rounded,
                  onTap: () {
                    _onRateUsTap();
                  },
                ),
                DrawerItem(
                  title: context.tt('navSettings'),
                  icon: Icons.settings_outlined,
                  // onTap: () => MyRouter().route(context, const SettingsPage()),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SettingsScreen.routeName);
                  },
                ),
                DrawerItem(
                  title: context.tt('navExit'),
                  icon: Icons.logout,
                  // onTap: () => MyRouter().route(context, const SettingsPage()),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<AuthProvider>().logout();
                    showDialogSuccess(context);
                    // showToast(context, "User successfully logged out");
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.copyright_rounded),
                    Text(
                      '${DateTime.now().toString().substring(0, 4)} Arzan. All rights reserved',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const DrawerItem(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        // color: Palette.kSoftGreen,
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }
}

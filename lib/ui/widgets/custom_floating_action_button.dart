import 'package:provider/provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/screens/add_post/add_post_screen.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.all(5),
      child: FloatingActionButton(
        onPressed: () {
          // showDialog(
          //     context: context,
          //     builder: (context) => const InternetErrorDialog());
          if (isUserLoggedIn) {
            // Navigator.pushNamed(context, AddPostScreen.routeName);
            Navigator.pushNamed(context, ProfileSettingScreen.routeName);
          } else {
            showDialogToLogin(context);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kSoftGreen,
          ),
          child: const Icon(Icons.add_rounded, size: 50),
          // child: SvgPicture.asset('assets/icons/fi-rr-add.svg'),
        ),
      ),
    );
  }
}

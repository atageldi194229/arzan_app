// import 'package:tm/core/providers/account_provider.dart';
// import 'package:tm/core/providers/auth_provider.dart';
// import 'package:provider/provider.dart';

import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/profile/components/body.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_floating_action_button.dart';


// import 'components/body.dart';

// class ProfileScreen extends StatefulWidget {
//   static String routeName = '/profile';
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();

//     AuthProvider _auth = context.read<AuthProvider>();
//     context.read<AccountProvider>().initUser(
//           userId: _auth.userId,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kScaffoldColor,
//       appBar: DefaultAppBar(title: 'Profile'),
//       body: Body(),
//     );
//   }
// }


class ProfileScreen extends StatelessWidget {
    static String routeName = '/profile';
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: DefaultAppBar(title: 'My Profile'),
      body: Body(),
        extendBody: true,
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: CustomFloatingActionButton(),
        drawer: CustomDrawer(),
    );
  }
}

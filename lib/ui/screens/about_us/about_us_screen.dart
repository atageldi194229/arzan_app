import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/size_config.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = '/about_us';

  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar:
      // const CustomBottomNavBar(selectedMenu: MenuState.home),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // floatingActionButton: const CustomFloatingActionButton(),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: size.width,
              height: size.height / 3,
              color: Colors.green,
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                color: Colors.white,
                boxShadow: kBoxShadow,
              ),
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: size.height / 4,
              ),
              padding: EdgeInsets.only(
                top: size.width / 4,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    context.tt('navAboutUs'),
                    // 'About Us',
                    style: Theme.of(context).textTheme.headline6!.copyWith(),
                  ),
                  const SizedBox(height: kDilegSizedBox + 5),
                  Text(
                    context.tt('aboutUsText'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Positioned(
              top: SizeConfig.screenHeight * 0.2,
              child: Image.asset('assets/images/aboutUs.png',
                  width: SizeConfig.screenWidth * 0.3,
                  height: SizeConfig.screenWidth * 0.3,
                  fit: BoxFit.fill),
            )
          ],
        ),
      ),
    );
  }
}

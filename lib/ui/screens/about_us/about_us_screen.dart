import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = '/about_us';

  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
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
              width: _size.width,
              height: _size.height / 3,
              color: Colors.green,
            ),
            Container(
              width: _size.width,
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                color: Colors.white,
                boxShadow: kBoxShadow,
              ),
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: _size.height / 4,
              ),
              padding: EdgeInsets.only(
                top: _size.width / 4,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'About Us',
                    style: Theme.of(context).textTheme.headline6!.copyWith(),
                  ),
                  Text(
                    context.tt('aboutUsText'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Container(
              width: _size.width / 2.5,
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(top: _size.height / 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: kBoxShadow),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: kSoftGreen,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Image.asset('assets/images/logo_ticket.png'),
                    ),
                    const Flexible(
                      flex: 2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Arzan',
                          style: TextStyle(
                            fontFamily: 'Arista',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

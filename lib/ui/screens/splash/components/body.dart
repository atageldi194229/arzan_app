import 'dart:async';

import 'package:tm/core/api/api_path.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/core/providers/banner_provider.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/size_config.dart';
import 'package:provider/provider.dart';

// This is the best practice
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _progress = 0;
  bool _isConnectionProblem = false;
  String _progressText = "Initialization";

  void _initAllData() {
    context.read<AuthProvider>().initData();
    context.read<BannerProvider>().initData();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ApiPath.searchForConnection().then((dynamic result) {
        if (result is bool) {
          if (result == true) {
            setState(() {
              _progress++;
              _progressText = "Progress done.";
            });

            _initAllData();

            Timer(
              const Duration(milliseconds: 300),
              () {
                Navigator.pop(context);
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
            );
          } else {
            setState(() {
              _isConnectionProblem = true;
              _progressText = "Internet connection problem";
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            child: AnimatedContainer(
              duration: const Duration(seconds: 5),
              curve: Curves.linear,
              decoration: const BoxDecoration(
                gradient: aPrimaryGradientColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 5),
                  Image.asset(
                    'assets/images/logo_ticket.png',
                    width: getProportionateScreenWidth(200),
                  ),
                  Text(
                    "Arzan",
                    style: TextStyle(
                      fontFamily: 'Arista',
                      fontSize: getProportionateScreenWidth(70),
                      color: Colors.white, // aPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ÝURDUMYZYŇ ÄHLI KÜNJEGINDE",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      color: Colors.white,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(flex: 5),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  _progressText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.lightBlue.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

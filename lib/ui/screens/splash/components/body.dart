import 'package:tm/core/api/api_path.dart';
import 'package:tm/core/api/models/region_model.dart';
import 'package:tm/core/api/services/main_service.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/core/providers/banner_provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/select_region/select_region_screen.dart';
import 'package:tm/ui/size_config.dart';
import 'package:provider/provider.dart';

// This is the best practice
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _progressText = "Initialization";

  _onDone(Function() fn, Function callback) async {
    await fn();
    callback();
  }

  _initAllData(Function onDone) {
    context.read<BannerProvider>().initData();
    _onDone(context.read<AuthProvider>().initData, onDone);
  }

  _initRegions() async {
    return MainService().fetchData().then((data) {
      context.read<RegionProvider>().regions = List.from(data['regions'])
          .map<RegionModel>((e) => RegionModel.fromMap(e))
          .toList();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  _initUser() {
    AuthProvider auth = context.read<AuthProvider>();
    return context.read<AccountProvider>().initUser(userId: auth.userId);
  }

  _handleNextPage() {
    if (context.read<RegionProvider>().isCurrentRegionSelected) {
      Navigator.pop(context);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, SelectRegion.routeName);
    }
  }

  _initDefaultRegion() {
    context.read<RegionProvider>().addListenerToPref(_handleNextPage);
  }

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      ApiPath.searchForConnection().then((dynamic result) async {
        if (result is bool) {
          if (result == true) {
            setState(() {
              _progressText = "Progress done.";
            });

            await _initAllData(() async {
              _initUser();
              await _initRegions();

              _initDefaultRegion();
              // _handleNextPage();
            });
            // Timer(
            //   const Duration(milliseconds: 300),
            //   () {
            //   },
            // );
          } else {
            setState(() {
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

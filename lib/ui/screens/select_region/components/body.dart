import 'package:provider/provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:tm/ui/screens/select_region/components/city_button.dart';
import 'package:tm/ui/size_config.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> cities = [
  {"id": 1, "name": "Ashgabat"},
  {"id": 2, "name": "Balkan"},
  {"id": 3, "name": "Ahal"},
  {"id": 4, "name": "Lebap"},
  {"id": 5, "name": "Dashoguz"},
  {"id": 6, "name": "Mary"},
];

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var regions = context.watch<RegionProvider>().regions;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        // height: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.linear,

          decoration: const BoxDecoration(
            gradient: aPrimaryGradientColor,
          ),
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [kSoftGreen, kHardGreen],
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              Expanded(
                flex: 5,
                child: Image.asset('assets/images/map.png'),
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Text(
                      "Sebitiňizi saýlaň:",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.white,
                        // fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Column(
                      children: List.generate(
                        cities.length,
                        (index) => Container(
                          margin: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(10),
                          ),
                          child: CityButton(
                            text: regions[index].name,
                            press: () {
                              context.read<RegionProvider>().currentRegionId =
                                  regions[index].id;
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Image.asset(
              //   'assets/images/logo_ticket.png',
              //   width: getProportionateScreenWidth(200),
              // ),
              // Text(
              //   "Arzan",
              //   style: TextStyle(
              //     fontSize: getProportionateScreenWidth(70),
              //     color: Colors.white, // aPrimaryColor,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Text(
              //   "ÝURDUMYZYŇ ÄHLI KÜNJEGINDE",
              //   style: TextStyle(
              //     fontSize: getProportionateScreenWidth(15),
              //     color: Colors.white,
              //     // fontWeight: FontWeight.bold
              //   ),
              // ),
              // // const AutoSizeText(
              // //   'ÝURDUMYZYŇ ÄHLI KÜNJEGINDE',
              // //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              // // ),
              // const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}

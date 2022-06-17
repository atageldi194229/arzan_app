import 'package:provider/provider.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/banner_provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:tm/ui/screens/select_region/components/city_button.dart';
import 'package:tm/ui/size_config.dart';
import 'package:flutter/material.dart';

// List<Map<String, dynamic>> cities = [
//   {"id": 1, "name": "Ashgabat"},
//   {"id": 2, "name": "Balkan"},
//   {"id": 3, "name": "Ahal"},
//   {"id": 4, "name": "Lebap"},
//   {"id": 5, "name": "Dashoguz"},
//   {"id": 6, "name": "Mary"},
// ];

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  _goToNextPage(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(
      context,
      HomeScreen.routeName,
    );
  }

  _onRegionTap(BuildContext context, RegionModel region) {
    context.read<RegionProvider>().currentRegionId = region.id;
    context.read<BannerProvider>().initData(regionId: region.id);
    _goToNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RegionProvider>();
    var regions = provider.regions;

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
                        regions.length,
                        (index) => Container(
                          margin: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(10),
                          ),
                          child: CityButton(
                            text: regions[index].name,
                            press: () => _onRegionTap(context, regions[index]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

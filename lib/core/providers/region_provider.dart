import 'package:tm/core/api/models/region_model.dart';
import 'package:flutter/material.dart';

class RegionProvider with ChangeNotifier {
  late List<RegionModel> _regions = <RegionModel>[];
  int currentRegionId = 0;

  RegionModel get currentRegion {
    return _regions.firstWhere(
      (region) => region.id == currentRegionId,
      orElse: () => RegionModel(id: 0, name: "Ashgabat"),
    );
  }

  List<RegionModel> get regions => _regions;

  set regions(value) {
    _regions = value;
    notifyListeners();
  }

  // initData() {
  //   return MainService()
  //       .fetchData()
  //       .then((banners) => this.banners = banners);
  // }
}

import 'package:tm/core/api/models/region_model.dart';
import 'package:flutter/material.dart';

class RegionProvider with ChangeNotifier {
  late List<RegionModel> _regions = <RegionModel>[];
  int currentRegionId = 0;

  //TODO: currentRegionId yzyny dowam et

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

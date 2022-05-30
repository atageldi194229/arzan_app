import 'package:tm/core/api/services/banner_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:tm/core/api/models/banner_model.dart';

class BannerProvider with ChangeNotifier {
  late List<BannerModel> _banners = <BannerModel>[];

  List<BannerModel> get banners => _banners;

  set banners(value) {
    _banners = value;
    notifyListeners();
  }

  initData() {
    return BannerService()
        .fetchData()
        .then((banners) => this.banners = banners);
  }
}

import 'package:tm/core/api/services/banner_service.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:tm/core/api/models/banner.dart' as models;

class BannerProvider with ChangeNotifier {
  late List<models.Banner> _banners = <models.Banner>[];

  get banners => _banners;

  set banners(value) {
    _banners = value;
    notifyListeners();
  }

  initData() {
    return BannerService().fetchData().then((_banners) => banners = _banners);
  }
}

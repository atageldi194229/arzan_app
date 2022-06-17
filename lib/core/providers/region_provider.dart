import 'package:shared_preferences/shared_preferences.dart';
import 'package:tm/core/api/models/region_model.dart';
import 'package:flutter/material.dart';

const String prefsCurrentRegionIdKey = "CURRENT_REGION_ID";

class RegionProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static final List<Function> _prefListeners = [];

  RegionProvider() : super() {
    _initCurrentRegion();
  }

  addListenerToPref(Function callback) {
    _prefListeners.add(callback);
  }

  late List<RegionModel> _regions = <RegionModel>[];
  int _currentRegionId = 0;

  get isCurrentRegionSelected => _currentRegionId != 0;

  set currentRegionId(value) {
    _currentRegionId = value;
    notifyListeners();

    _prefs.then((prefs) {
      prefs.setInt(prefsCurrentRegionIdKey, value);
    });
  }

  int get currentRegionId => _currentRegionId;

  RegionModel get currentRegion {
    return _regions.firstWhere(
      (region) => region.id == currentRegionId,
      orElse: () => RegionModel(id: 1, name: "Ashgabat"),
    );
  }

  List<RegionModel> get regions => _regions;

  set regions(List<RegionModel> list) {
    list.sort((b, a) => a.order.compareTo(b.order));
    _regions = list;
    notifyListeners();
  }

  _initCurrentRegion() {
    _prefs.then((prefs) {
      currentRegionId = prefs.getInt(prefsCurrentRegionIdKey) ?? 0;

      for (var listener in _prefListeners) {
        listener();
      }
    });
  }
}

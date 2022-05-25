import 'package:tm/core/api/services/region_status_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

class RegionStatusProvidor extends ChangeNotifier {
  //  models.RegionStatusModel _post = models.RegionStatusModel ;
  List<models.RegionStatusModel> list = [];
  models.RegionStatusModel? selectRegion;
  bool isFetching = false;

  setSelectedRegion(models.RegionStatusModel value) {
    selectRegion = value;
    notifyListeners();
  }

  addAllPosts(List<models.RegionStatusModel> postList) {
    list.addAll(postList);
    notifyListeners();
  }

  loadStatistics() async {
    if (isFetching) return;
    isFetching = true;

    try {
      var _list = await RegionStatusService().getRegions();
      print(_list);
      addAllPosts(_list);
    } catch (err) {
      debugPrint(err.toString());
    }

    isFetching = false;
  }
}

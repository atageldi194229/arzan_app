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

  addAllPosts(List<models.RegionStatusModel> itemList) {
    list.addAll(itemList);
    notifyListeners();
  }

  loadStatistics() async {
    debugPrint("Region stat load statistics function");

    if (isFetching) return;
    isFetching = true;

    try {
      debugPrint("Region stat load started");
      var itemList = await RegionStatusService().getRegions();
      debugPrint('regions stat length: ${itemList.length}');
      addAllPosts(itemList);
    } catch (err) {
      debugPrint(err.toString());
    }

    isFetching = false;
  }
}

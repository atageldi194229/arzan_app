import 'package:tm/core/api/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

class NotificationProvider extends ChangeNotifier {
  bool isFetching = false;
  final List<models.NotificationModel> _items = [];

  get items => _items;

  int limit = 20;
  int offset = 0;

  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  get currentItem => items[_currentIndex];

  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  fetchData() async {
    if (isFetching) return;
    isFetching = true;

    try {
      var itemList = await NotificationService().fetchData(
        limit: limit,
        offset: offset,
      );

      offset += limit;

      _items.addAll(itemList);

      notifyListeners();
    } finally {
      isFetching = false;
    }
  }
}

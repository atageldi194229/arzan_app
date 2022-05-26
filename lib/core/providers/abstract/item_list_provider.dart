import 'package:flutter/material.dart';

abstract class ItemListProvider<T> extends ChangeNotifier {
  bool isFetching = false;
  final List<T> _items = [];

  int _limit = 20;
  int offset = 0;

  int get limit => _limit;
  set limit(value) => _limit = value;

  int _currentIndex = 0;

  List<T> get items => _items;
  int get currentIndex => _currentIndex;
  T get currentItem => _items[_currentIndex];

  setCurrentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  addAllItems(List<T> itemList) {
    _items.addAll(itemList);
    offset += limit;
    notifyListeners();
  }

  load() async {
    if (isFetching) return;
    isFetching = true;

    try {
      List<T> list = await fetchItems(limit, offset);
      addAllItems(list);
    } catch (err) {
      debugPrint(err.toString());
    }

    isFetching = false;
  }

  Future<List<T>> fetchItems(int limit, int offset);
}

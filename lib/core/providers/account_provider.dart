import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  UserModel? _user;
  int _userId = 0;

  get user => _user;

  set user(value) {
    _user = value;
    notifyListeners();
  }

  _fetchData() async {
    user = await AccountService().fetchData(userId: _userId);
  }

  initUser({required int userId}) {
    _userId = userId;
    _fetchData();
  }
}

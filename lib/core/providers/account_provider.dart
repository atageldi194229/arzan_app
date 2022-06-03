import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  UserModel? _user;
  int _userId = 0;
  bool _isFetching = false;

  UserModel? get user => _user;

  set user(value) {
    _user = value;
    notifyListeners();
  }

  _fetchData() async {
    try {
      user = await AccountService().fetchData(userId: _userId);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  _initFollowingIdList() async {
    if (_user == null) return;

    try {
      _user!.followingIdList = await AccountService().fetchFollowingIdList();
      notifyListeners();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  initUser({required int userId}) async {
    if (_isFetching) return;
    _isFetching = true;

    _userId = userId;
    await _fetchData();
    _isFetching = false;
    _initFollowingIdList();
  }

  follow(int userId, bool isFollowing) {
    debugPrint('_user is null:  ${(_user == null).toString()}');

    if (_user == null) return;

    List<int> defaultFollowingList = _user!.followingIdList;

    final Future request;

    if (isFollowing) {
      _user!.followingIdList.add(userId);
      request = AccountService().follow(userId: userId);
    } else {
      _user!.followingIdList.remove(userId);
      request = AccountService().unfollow(userId: userId);
    }

    notifyListeners();

    request.catchError((error) {
      _user!.followingIdList = defaultFollowingList;
      notifyListeners();
    });
  }
}
